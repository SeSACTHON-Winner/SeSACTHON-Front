//
//  CLLocation.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 02/02/2023.
//

import Foundation
import CoreLocation

extension Array where Element == CLLocation {
    
    // 일련의 CLLocation을 통해 이동한 총 거리를 계산합니다
    var distance: Double {
        guard count > 1 else { return 0 }
        var distance = Double.zero
        
        // 각 CLLocation 쌍 사이의 거리를 계산하여 표의 모든 항목을 찾습니다
        for i in 0..<count-1 {
            let location = self[i]
            let nextLocation = self[i+1]
            distance += nextLocation.distance(from: location)
        }
        return distance
    }
    
    var elevation: Double {
        guard count > 1 else { return 0 }
        var elevation = Double.zero
        
        for i in 0..<count-1 {
            let location = self[i]
            let nextLocation = self[i+1]
            let delta = nextLocation.altitude - location.altitude
            if delta > 0 {
                elevation += delta
            }
        }
        return elevation
    }
}
