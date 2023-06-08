//
//  HKHelper.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 23/01/2023.
//

import Foundation
import HealthKit
import CoreLocation
import MapKit

struct HKHelper {
    static let healthStore = HKHealthStore()
    static let available = HKHealthStore.isHealthDataAvailable()
    
    // requestAuth() 메서드는 사용자에게 자신의 건강 데이터에 접근할 수 있는 권한을 요청한다.
    static func requestAuth() async -> HKAuthorizationStatus {
        // HealthKit에서 공유하고 읽을 데이터의 종류를 정의합니다.
        let types: Set = [
            HKObjectType.workoutType(),
            HKSeriesType.workoutRoute(),
            //HKQuantityType.activitySummaryType() //TODO: 여기 칼로리서 찾아보기??
        ]
        
        // 위에서 정의한 데이터 형식에 대한 접근 권한을 요청합니다.
        try? await healthStore.requestAuthorization(toShare: types, read: types)
        return status
    }
    
    // 훈련 데이터 및 경로 데이터 형식에 대한 승인 상태를 확인한다.
    static var status: HKAuthorizationStatus {
        // 두 종류의 데이터를 공유할 수 있는 권한이 있는지 여부를 결정합니다.
        let workoutStatus = healthStore.authorizationStatus(for: HKObjectType.workoutType())
        let routeStatus = healthStore.authorizationStatus(for: HKSeriesType.workoutRoute())
        
        // 두 종류의 데이터를 공유할 수 있는 권한이 있는지 여부를 결정합니다.
        if workoutStatus == .sharingAuthorized && routeStatus == .sharingAuthorized {
            return .sharingAuthorized
        } else if workoutStatus == .notDetermined && routeStatus == .notDetermined {
            return .notDetermined
        } else {
            return .sharingDenied
        }
    }
    
    // loadWorkout 메서드는 사용자의 건강 데이터로부터 훈련 목록을 로드한다.
    static func loadWorkouts(completion: @escaping ([HKWorkout]) -> Void) {
        // 가장 최근의 것부터 가장 오래된 것까지 시작 날짜별로 정렬하기 위한 훈련 요청의 결과에 대한 정렬 정의.
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sort]) { query, samples, error in
            guard let workouts = samples as? [HKWorkout] else {
                completion([])
                return
            }
            completion(workouts)
        }
        healthStore.execute(query)
    }
    
    // Workout Route load 방식은 사용자의 건강 데이터로부터 훈련 경로를 로드한다.
    static func loadWorkoutRoute(hkWorkout: HKWorkout, completion: @escaping ([CLLocation]) -> Void) {
        // 훈련 코스에 대한 훈련 시리즈 표본 타입을 정의한다.
        let type = HKSeriesType.workoutRoute()
        
        // 트레이닝 시리즈를 가져오기 위한 술어
        let predicate = HKQuery.predicateForObjects(from: hkWorkout)
        
        let routeQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            guard let route = samples?.first as? HKWorkoutRoute else {
                completion([])
                return
            }
            
            var locations = [CLLocation]()
            let locationsQuery = HKWorkoutRouteQuery(route: route) { query, newLocations, finished, error in
                locations.append(contentsOf: newLocations ?? [])
                if finished {
                    completion(locations)
                }
            }
            self.healthStore.execute(locationsQuery)
        }
        healthStore.execute(routeQuery)
    }
}



