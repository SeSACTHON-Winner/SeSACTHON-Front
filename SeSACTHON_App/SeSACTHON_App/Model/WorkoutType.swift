//
//  WorkoutType.swift
//  Running
//
//  Created by Lee Jinhee on 2023/06/08.
//

import HealthKit
import SwiftUI

enum WorkoutType: String, CaseIterable {
    case walk = "Walk"
    case run = "Run"
    case other = "Other"
    
    var colour: Color {
        switch self {
        case .walk:
            return .green
        case .run:
            return .red
        case .other:
            return .yellow
        }
    }
    
    var hkType: HKWorkoutActivityType {
        switch self {
        case .walk:
            return .walking
        case .run:
            return .running
        default:
            return .other
        }
    }
    
    init(hkType: HKWorkoutActivityType) {
        switch hkType {
        case .walking:
            self = .walk
        case .running:
            self = .run
        default:
            self = .other
        }
    }
}
