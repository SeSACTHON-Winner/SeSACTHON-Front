//
//  Workout.swift
//  Running
//
//  Created by Lee Jinhee on 2023/06/08.
//

import Foundation
import HealthKit
import MapKit
import CoreLocation

class Workout: NSObject {
    let type: WorkoutType
    let polyline: MKPolyline
    let locations: [CLLocation]
    let date: Date
    let duration: Double // 초 단위의 운동 시간
    let distance: Double // 운동 중에 이동한 총 거리
    let elevation: Double // 운동의 총 고도차

    
    
    init(type: WorkoutType, polyline: MKPolyline, locations: [CLLocation], date: Date, duration: Double) {
        self.type = type
        self.polyline = polyline
        self.locations = locations
        self.date = date
        self.duration = duration
        self.distance = locations.distance //CLLocation 클래스의 확장을 사용하여 총 거리를 계산합니다.
        self.elevation = locations.elevation //CLLocation 클래스의 확장을 사용하여 총 고도차를 계산합니다.
    }
    
    convenience init(hkWorkout: HKWorkout, locations: [CLLocation]) {
        let coords = locations.map(\.coordinate)
        let type = WorkoutType(hkType: hkWorkout.workoutActivityType) // HealthKit의 운동 타입을 로컬 운동 타입으로 변환합니다.
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        let date = hkWorkout.startDate
        let duration = hkWorkout.duration
        
        // 심박수 데이터 가져오기
       // let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
        //let predicate = HKQuery.predicateForSamples(withStart: hkWorkout.startDate, end: hkWorkout.endDate, options: .strictEndDate)
        
//        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .heartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
//        }
        let quantityType = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
        }
        
        HKHealthStore().execute(quantityType)
        
        let workout = Workout(type: type, polyline: polyline, locations: locations, date: date, duration: duration)
        self.init(type: workout.type, polyline: workout.polyline, locations: workout.locations, date: workout.date, duration: workout.duration)
    }

    static let example = Workout(type: .walk, polyline: MKPolyline(), locations: [], date: .now, duration: 3456)
}

extension Workout: MKOverlay {
    var coordinate: CLLocationCoordinate2D {
        polyline.coordinate
    }
    
    var boundingMapRect: MKMapRect {
        polyline.boundingMapRect
    }
}
