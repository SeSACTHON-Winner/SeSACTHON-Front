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
    let type: HKWorkoutActivityType
    let polyline: MKPolyline
    let locations: [CLLocation]
    let date: Date
    let duration: Double // 초 단위의 운동 시간
    let distance: Double // 운동 중에 이동한 총 거리
    //let elevation: Double // 운동의 총 고도차
    var calories: Double // 소모된 총 칼로리
    let pace: Double // 평균 페이스
   
    
    init(type: HKWorkoutActivityType, polyline: MKPolyline, locations: [CLLocation], date: Date, duration: Double, calories: Double, pace: Double) {
        self.type = type
        self.polyline = polyline
        self.locations = locations
        self.date = date
        self.duration = duration
        self.distance = locations.distance //CLLocation 클래스의 확장을 사용하여 총 거리를 계산합니다.
        //self.elevation = locations.elevation //CLLocation 클래스의 확장을 사용하여 총 고도차를 계산합니다.
        self.calories = calories
        self.pace = pace
    }
    
    //TODO: 칼로리 단위 수정
    convenience init(hkWorkout: HKWorkout, locations: [CLLocation]) {
        let coords = locations.map(\.coordinate)
        let type = hkWorkout.workoutActivityType // HealthKit의 운동 타입을 로컬 운동 타입으로 변환합니다.
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        let date = hkWorkout.startDate
        let duration = hkWorkout.duration
        
        var calories: Double = 0.0
        let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
        let predicate = HKQuery.predicateForSamples(withStart: hkWorkout.startDate, end: hkWorkout.endDate, options: .strictEndDate)
        let energyQuery = HKSampleQuery(sampleType: energyType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKQuantitySample] else {
                // Handle error
                return
            }

            for sample in samples {
                let energy = sample.quantity.doubleValue(for: HKUnit.largeCalorie())
                print("energyquery", energy)

                calories += energy
            }
        }
        
        let paceType = HKQuantityType.quantityType(forIdentifier: .runningSpeed)!
        var pace: Double = 0.0
        let paceQuery = HKStatisticsQuery(quantityType: paceType, quantitySamplePredicate: predicate, options: .discreteAverage) { query, result, error in
            guard let result = result, let averagePace = result.averageQuantity() else {
                // Handle error
                return
            }
            //TODO: Kilometer로 수정
            //HKUnit.init(from: “km/s”)
            pace = averagePace.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
        }
        
        let queryGroup = DispatchGroup()
        queryGroup.enter()
        
        HKHealthStore().execute(energyQuery)
        HKHealthStore().execute(paceQuery)
        
        let workout = Workout(type: type, polyline: polyline, locations: locations, date: date, duration: duration, calories: calories, pace: pace)
        self.init(type: workout.type, polyline: workout.polyline, locations: workout.locations, date: workout.date, duration: workout.duration, calories: workout.calories, pace: workout.pace)
        
        queryGroup.notify(queue: .main) {
            
        }
    }
    
    static let example = Workout(type: .running, polyline: MKPolyline(), locations: [], date: .now, duration: 3456, calories: 0.0, pace: 0.0)
}

//
//        let quantityType = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
//        }
//
//        HKHealthStore().execute(quantityType)
//
//        let workout = Workout(type: type, polyline: polyline, locations: locations, date: date, duration: duration)
//        self.init(type: workout.type, polyline: workout.polyline, locations: workout.locations, date: workout.date, duration: workout.duration)
//    }
//
//    static let example = Workout(type: .run, polyline: MKPolyline(), locations: [], date: .now, duration: 3456)
//}

extension Workout: MKOverlay {
    var coordinate: CLLocationCoordinate2D {
        polyline.coordinate
    }
    
    var boundingMapRect: MKMapRect {
        polyline.boundingMapRect
    }
}
