//
//  WorkoutType.swift
//  Running
//
//  Created by Lee Jinhee on 2023/06/08.
//

import HealthKit
import SwiftUI

enum WorkoutType: String, CaseIterable {
    case run = "Run"
    case other = "Other"
    
    var colour: Color {
        switch self {
        case .run:
            return .black.opacity(0.4)
        case .other:
            return .black.opacity(0.1)
        }
    }
    
    var hkType: HKWorkoutActivityType {
        switch self {
        case .run:
            return .running
        default:
            return .other
        }
    }
    
    init(hkType: HKWorkoutActivityType) {
        switch hkType {
        case .running:
            self = .run
        default:
            self = .other
        }
    }
}
