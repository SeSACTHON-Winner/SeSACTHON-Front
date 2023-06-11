//
//  ViewModel.swift
//  Running
//
//  Created by Lee Jinhee on 2023/06/08.
//

import Foundation
import HealthKit
import MapKit
import SwiftUI
import Combine


// MainActor를 사용하면 모든 뷰 템플릿 업데이트가 주 스레드에서 수행되도록 할 수 있다.
@MainActor
class WorkoutViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    // Workout Tracking
    @Published var recording = false // 현재 트레이닝 모니터링이 활성 상태인지 여부
    @Published var type = WorkoutType.other
    @Published var startDate = Date()
    @Published var metres = 0.0 // 추적하는 동안 이동한 거리
    @Published var locations = [CLLocation]() // 경로를 나타내는 CLLocation 전체 배열
    @Published var calory = 0.0
    @Published var pace = 0.0

    // 위치 표를 기반으로 MKPolyline을 반환하는 계산 속성
    var polyline: MKPolyline {
        let coords = locations.map(\.coordinate)
        return MKPolyline(coordinates: coords, count: coords.count)
    }
    
    // View Model의 현재 상태를 기반으로 새 훈련 객체를 반환하는 계산된 속성입니다.
    var newWorkout: Workout {
        let duration = Date.now.timeIntervalSince(startDate)
        return Workout(type: type, polyline: polyline, locations: locations, date: startDate, duration: duration, calories: calory, pace: pace)
    }
    
    
    // HealthKit 속성 및 사용 권한
    @Published var showPermissionsView = false
    @Published var healthUnavailable = !HKHelper.available
    @Published var healthStatus = HKAuthorizationStatus.notDetermined
    @Published var healthLoading = false
    
    // HealthKit 권한이 부여되었을 때 반환하는 속성입니다.
    var healthAuth: Bool { healthStatus == .sharingAuthorized }
    
    // HealthKit 스토어는 요청 시 HealthKit 인증을 사용합니다.
    let healthStore = HKHealthStore()
    
    // CLocationManager는 훈련 중에 사용자의 위치를 추적하는 데 사용됩니다.
    var locationManager = CLLocationManager()
    
    //HKWorkoutBuilder와 HKWorkoutRouteBuilder는 HealthKit에서 훈련을 추적하는 데 사용됩니다.
    var workoutBuilder: HKWorkoutBuilder?
    var routeBuilder: HKWorkoutRouteBuilder?
    
    // 녹화 중 훈련의 경과 시간을 업데이트하는 타이머를 취소하는 데 사용됩니다.
    var timer: Cancellable?
    
    // Map 맵 속성
    @Published var trackingMode = MKUserTrackingMode.none
    @Published var mapType = MKMapType.standard
    @Published var accuracyAuth = false
    @Published var locationStatus = CLAuthorizationStatus.notDetermined
    
    // 위치 권한이 부여되었을 때 반환
    var locationAuth: Bool { locationStatus == .authorizedAlways }
    // 지도를 표시하는 MKmapView
    var mapView: MKMapView?
    
    // Workouts
    // 사용자가 완료한 트레이닝 테이블입니다.
    @Published var workouts = [Workout]()
    
    // 워크아웃 유형 및 워크아웃 날짜를 기준으로 필터링한 트레이닝 테이블.
    @Published var filteredWorkouts = [Workout]()
    
    // 훈련이 쌓이고 있는 중인지 여부를 나타냅니다.
    @Published var loadingWorkouts = true
    
    // 현재 선택된 연습
    @Published var selectedWorkout: Workout? { didSet {
        updatePolylines()
        filterWorkouts()
    }}
    
    // Filters
    // 현재 선택된 트레이닝 타입 필터입니다.
    @Published var workoutType: WorkoutType? { didSet {
        filterWorkouts()
    }}
    
    
    // 현재 선택된 트레이닝 날짜 필터입니다.
    @Published var workoutDate: WorkoutDate? { didSet {
        filterWorkouts()
    }}
    
    // View
    @Published var degrees = 0.0
    @Published var scale = 1.0
    @Published var pulse = false
    @Published var showInfoView = false
    @Published var showRunListView = false

    // Errors
    @Published var showErrorAlert = false
    @Published var error = MyMapError.noWorkouts
    func showError(_ error: MyMapError) {
        self.error = error
        self.showErrorAlert = true
        Haptics.error()
    }
    
    // MARK: - Initialiser
    override init() {
        super.init()
        setupLocationManager() // 위치 관리자 설정을 위해 함수를 호출합니다.
        updateHealthStatus() // 상태 업데이트 중
        if healthAuth { // 프로그램이 건강 데이터에 접근할 수 있는 권한을 가지면
            loadWorkouts()// 과거 기록 데이터를 불러옵니다
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self // 위치 업데이트 관리를 위한 위임자 설정
    }
    
    func requestLocationAuthorisation() {
        if locationStatus == .notDetermined { // 위치 허가 상태가 아직 결정되지 않은 경우
            locationManager.requestWhenInUseAuthorization() // 사용 중인 위치에 대한 접근 권한을 요청합니다.
        } else { // 위치 인증이 이미 결정되면
            locationManager.requestAlwaysAuthorization() // 현재 위치에 대한 접근 권한을 요청합니다.
        }
    }
    
    func updateHealthStatus() {
        healthStatus = HKHelper.status // 건강 데이터에 접근하기 위한 허가 상태를 업데이트합니다
        if !healthAuth {// 프로그램에 건강 데이터에 접근할 수 있는 권한이 없는 경우
            showPermissionsView = true // 건강 데이터에 접근하기 위한 권한 보기 보이기
        }
    }
    
    func requestHealthAuthorisation() async {
        healthLoading = true // 불러오기 스피너 사용하기
        healthStatus = await HKHelper.requestAuth() // 건강 데이터에 접근하기 위해 승인을 기다리는 중
        if healthAuth { // 프로그램에서 건강 데이터에 접근할 수 있는 권한을 가지면
            loadWorkouts() // 과거 기록 데이터를 불러옵니다
        }
        healthLoading = false // 불러오기 스피너 사용하지 않기
    }
    
    // MARK: - Workouts
    
    // HealthKit API에서 트레이닝 불러오기
    func loadWorkouts() {
        loadingWorkouts = true
        HKHelper.loadWorkouts { hkWorkouts in
            // 트레이닝이 반환되었는지 확인합니다.
            guard !hkWorkouts.isEmpty else {
                DispatchQueue.main.async {
                    self.loadingWorkouts = false
                }
                return
            }
            
            var tally = 0
            for hkWorkout in hkWorkouts {
                // HealthKit API에서 훈련 좌표 불러오기
                HKHelper.loadWorkoutRoute(hkWorkout: hkWorkout) { locations in
                    tally += 1
                    // 좌표가 반환되었는지 확인하십시오
                    if !locations.isEmpty {
                        // 트레이닝 데이터와 좌표를 사용하여 새 Workout 개체를 만듭니다
                        let workout = Workout(hkWorkout: hkWorkout, locations: locations)
                        
                        DispatchQueue.main.async {
                            // 연습 목록에 연습 추가
                            self.workouts.append(workout)
                            // 트레이닝을 표시할 지 확인합니다.
                            if self.showWorkout(workout) {
                                // 트레이닝을 표시할 경우 필터링된 트레이닝 목록에 추가한 후 지도에 표시합니다
                                self.filteredWorkouts.append(workout)
                                self.mapView?.addOverlay(workout, level: .aboveRoads)
                            }
                            
                        }
                        
                        // 칼로리 불러오기
                        HKHelper.loadCalories(for: hkWorkout) { calories in
                            DispatchQueue.main.async {
                                workout.calories = calories
                            }
                        }
                    }
                    // 모든 연습이 완료되었는지 확인합니다.
                    if tally == hkWorkouts.count {
                        DispatchQueue.main.async {
                            // 모든 연습이 완료되었다면, 로딩 애니메이션을 중지하십시오.
                            Haptics.success()
                            self.loadingWorkouts = false
                        }
                    }
                }
            }
        }
    }
    
    // 검색 기준에 따라 트레이닝 필터하기
    func filterWorkouts() {
        // 지도에서 기존 연습 삭제
        mapView?.removeOverlays(mapView?.overlays(in: .aboveRoads) ?? [])
        // 검색 기준에 따라 트레이닝 필터하기
        filteredWorkouts = workouts.filter { showWorkout($0) }
        // 필터링된 동작을 맵에 추가합니다.
        mapView?.addOverlays(filteredWorkouts, level: .aboveRoads)
        // 선택한 연습이 더 이상 보이지 않는지 확인하고 선택 취소
        if let selectedWorkout, !filteredWorkouts.contains(selectedWorkout) {
            self.selectedWorkout = nil
        }
    }
    
    
    // 검색 기준에 따라 트레이닝을 보일 지 여부입니다.
    func showWorkout(_ workout: Workout) -> Bool {
        // 현재 워크아웃이 선택되어 있는지, 아니면 현재 워크아웃이 선택되지 않았는지 확인합니다.
        // 워크아웃 유형이 선택한 워크아웃 유형과 일치하는지, 어떤 종류의 워크아웃도 선택하지 않았는지 검사합니다.
        // 워크아웃 날짜가 선택한 날짜와 일치하는지, 선택된 날짜가 아닌지를 검사합니다.

        (selectedWorkout == nil || workout == selectedWorkout) &&
        (workoutType == nil || workoutType == workout.type) &&
        (workoutDate == nil || Calendar.current.isDate(workout.date, equalTo: .now, toGranularity: workoutDate!.granularity))
    }
    
    func selectClosestWorkout(to targetCoord: CLLocationCoordinate2D) {
        let targetLocation = targetCoord.location
        var shortestDistance = Double.infinity
        var closestWorkout: Workout?
        
        // 현재 지도가 보이는지 검사합니다. 그렇지 않으면 기능을 중지합니다.
        guard let rect = mapView?.visibleMapRect else { return }
        let left = MKMapPoint(x: rect.minX, y: rect.midY)
        let right = MKMapPoint(x: rect.maxX, y: rect.midY)
        let maxDelta = left.distance(to: right) / 20
        
        
        // 모든 필터링된 작업을 통해 테이터
        for workout in filteredWorkouts {
            // 모든 워크아웃의 모든 경로를 통해 토글
            for location in workout.locations {
                let delta = location.distance(from: targetLocation)
                
                // 이전 작업보다 더 가깝고 최대 감지 영역 내에 있으면 가장 가까운 작업을 업데이트합니다.
                if delta < shortestDistance && delta < maxDelta {
                    shortestDistance = delta
                    closestWorkout = workout
                }
            }
        }
        selectWorkout(closestWorkout)
    }
    
    func selectWorkout(_ workout: Workout?) {
        // 지정한 작업 선택
        selectedWorkout = workout
        // 워크아웃을 선택하면 선택한 워크아웃을 확대합니다
        if let workout {
            zoomTo(workout)
        }
    }
    
    func zoomTo(_ overlay: MKOverlay) {
        var bottomPadding = 20.0
        // 워크아웃을 선택하면 추가 패딩을 추가합니다.
        if selectedWorkout != nil {
            bottomPadding += 160
        }
        // 저장 시 추가 패딩을 추가합니다.
        if recording {
            bottomPadding += 160
        }
        // 확대/ 축소 패딩을 설정하고 지정한 오버레이를 확대합니다.
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: bottomPadding, right: 20)
        mapView?.setVisibleMapRect(overlay.boundingMapRect, edgePadding: padding, animated: true)
    }
    
    // MARK: - Workout Tracking // 데이터 복구 부분을 추가
    
    func startWorkout(type: HKWorkoutActivityType) async {
        updateHealthStatus()
        guard healthAuth else { return }
        
        let config = HKWorkoutConfiguration() // 훈련할 수 있는 환경을 조성하다

        config.activityType = type // 입력 매개 변수에 따라 활동 유형을 설정합니다.

        config.locationType = .outdoor // 외부 경로의 종류를 설정합니다.
        
        self.type = WorkoutType(hkType: type) // 어떤 종류의 훈련이 적절한지 결정합니다.

        routeBuilder = HKWorkoutRouteBuilder(healthStore: healthStore, device: .local()) // GPS 데이터를 캡처하기 위한 경로 생성기를 만들었습니다.

        workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: .local())// 훈련 데이터를 캡처할 훈련 생성자를 만듭니다.

        do {
            try await workoutBuilder?.beginCollection(at: .now)
        } catch {
            self.showError(.startingWorkout)
            return
        }
        
        locationManager.allowsBackgroundLocationUpdates = true
        updateTrackingMode(.followWithHeading) // 사용자의 위치를 추적하기 위해 지도 보기를 업데이트합니다.
        
        Haptics.success()
        startDate = .now// 훈련 시작 날짜를 정하다
        pace = 0
        calory = 0
        recording = true
        timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect().sink { _ in // 0.5초마다 사용자 인터페이스를 진동시킬 수 있는 타이머를 만듭니다.

            self.pulse.toggle()
        }
    }

    
    func discardWorkout() {
        // 백그라운드에서 위치 업데이트를 금지하다
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.cancel()
        recording = false
        
        pace = 0
        calory = 0
        metres = 0
        locations = []
        updatePolylines()
        
        workoutBuilder?.discardWorkout()
        routeBuilder?.discard()
        Haptics.success()
    }
    
    func endWorkout() async {
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.cancel()
        recording = false
        
        var workout = newWorkout
        workouts.append(workout)
        updatePolylines()
        filterWorkouts()
        selectWorkout(workout)
        
       
        do {
            try await workoutBuilder?.endCollection(at: .now) // 훈련 자료 수집을 마쳤습니다.

            if let workout = try await workoutBuilder?.finishWorkout() { // 훈련을 마치다
                try await routeBuilder?.finishRoute(with: workout, metadata: nil) // GPS 데이터를 종료하다
            }
            Haptics.success()
        } catch {
            showError(.endingWorkout) // 작업을 완료하는 데 문제가 있으면 오류 메시지를 표시합니다.
        }
        metres = 0
        locations = []
        pace = 0
        calory = 0
    }
    
    // MARK: - Map
    func updateTrackingMode(_ newMode: MKUserTrackingMode) {
        // 지도 보기 사용자 추적 모드 업데이트
        mapView?.setUserTrackingMode(newMode, animated: true)
        // 화면크기 효과로 추적 모드 전환 애니메이션 사용하기
        if trackingMode == .followWithHeading || newMode == .followWithHeading {
            withAnimation(.easeInOut(duration: 0.25)) {
                scale = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.trackingMode = newMode
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.scale = 1
                }
            }
        } else {
            DispatchQueue.main.async {
                self.trackingMode = newMode
            }
        }
    }
    
    func updatePolylines() {
        // 존재하는 오버레이를 제거하고 지도 보기에 업데이트된 폴리선을 추가합니다.
        mapView?.removeOverlays(mapView?.overlays(in: .aboveLabels) ?? [])
        mapView?.addOverlay(polyline, level: .aboveLabels)
        
        // 해당되는 경우 선택한 연습의 폴리라인 추가
        if let selectedWorkout {
            mapView?.addOverlay(selectedWorkout.polyline, level: .aboveLabels)
        }
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        // 지도 보기의 선택된 위치에 가장 가까운 트레이닝을 선택하십시오
        guard let mapView = mapView else { return }
        let tapPoint = tap.location(in: mapView)
        let tapCoord = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        selectClosestWorkout(to: tapCoord)
    }
}

// MARK: - CLLocationManagerDelegate
extension WorkoutViewModel: CLLocationManagerDelegate {
    
    // 새 렌치를 사용할 수 있을 때 호출되는 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard recording else { return }
        
        // 위치 정밀도 검사
        let filteredLocations = locations.filter { location in
            location.horizontalAccuracy < 50
        }

        // 각 새 위치 사이의 미터 계산
        for location in filteredLocations {
            if let lastLocation = self.locations.last {
                metres += location.distance(from: lastLocation)
            }
            self.locations.append(location)
        }
        
        updatePolylines()
        
        // 지도 제작을 위한 경로 데이터 추가
        routeBuilder?.insertRouteData(locations) { success, error in
            guard success else {
                print("Error inserting locations")
                return
            }
        }
    }
    
    // 위치 변경이 있을 때 호출되는 함수
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        if locationAuth {
            manager.startUpdatingLocation()
            updateTrackingMode(.follow)
        } else {
            showPermissionsView = true
        }
        accuracyAuth = manager.accuracyAuthorization == .fullAccuracy
        if !accuracyAuth {
            showPermissionsView = true
        }
    }
}

// MARK: - MKMapView Delegate
extension WorkoutViewModel: MKMapViewDelegate {
    
    // 맵에서 오버레이를 보일 때 호출되는 함수
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // 오버레이가 폴리라인이면
        if let polyline = overlay as? MKPolyline {
            // 폴리라인 렌더링 만들기
            let render = MKPolylineRenderer(polyline: polyline)
            render.lineWidth = 8
            // 폴리선이 현재 트레이닝의 선택인 경우 주황색, 인디고 색상을 사용하십시오
            render.strokeColor = UIColor(polyline == selectedWorkout?.polyline ? Color("MainColor"): .black)
            return render
            // 오버레이가 연습이라면 (워크아웃)
        } else if let workout = overlay as? Workout {
            // 연습용 폴리라인 렌더링 만들기
            let render = MKPolylineRenderer(polyline: workout.polyline)
            render.lineWidth = 6
            // 트레이닝 형식과 연결된 색상 사용하기
            render.strokeColor = UIColor(workout.type.colour)
            return render
        }
        // 오버레이가 폴리라인이나 트레이닝이 아니라면 기본 렌더링을 사용하십시오
        return MKOverlayRenderer(overlay: overlay)
    }
    
    // 지도에서 사용자의 추적 모드가 바뀌었을 때 호출되는 함수
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        // Si le changement de mode n'est pas animé, mettre à jour le mode de suivi en aucun
        if !animated {
            updateTrackingMode(.none)
        }
    }
    
    // 사용자가 지도에서 주석을 선택할 때 호출되는 함수
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Désélectionner l'annotation sans animation
        mapView.deselectAnnotation(view.annotation, animated: false)
    }
}

