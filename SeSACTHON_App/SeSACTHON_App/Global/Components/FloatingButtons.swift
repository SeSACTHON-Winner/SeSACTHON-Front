//
//  FloatingButtons.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 13/01/2023.
//

import SwiftUI
import MapKit
import HealthKit

struct FloatingButtons: View {
    @EnvironmentObject var vm: WorkoutViewModel
    @State var showWorkoutTypeChoice = false
    @State var showStopConfirmation = false
    @State var showFilterView = false

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                updateTrackingMode()
            } label: {
                Image(systemName: trackingModeImage).resizable()
                    .frame(width: 42, height: 42)
                    .foregroundColor(.black).opacity(0.8)
                    .scaleEffect(vm.scale)
            }.padding(.trailing, 60)
            
            Menu {
                Picker("Date", selection: $vm.workoutDate) {
                    Text("All")
                        .tag(nil as WorkoutDate?)
                    ForEach(WorkoutDate.allCases.reversed(), id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type as WorkoutDate?)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("Type", selection: $vm.workoutType) {
                    Text("All")
                        .tag(nil as WorkoutType?)
                    ForEach(WorkoutType.allCases.reversed(), id: \.self) { type in
                        Label {
                            Text(type.rawValue + "s")
                        } icon: {
                            Image(uiImage: UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: UIColor(type.colour)))!)
                        }
                        .tag(type as WorkoutType?)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Filter Workouts")
            } label: {
                if vm.loadingWorkouts {
                    ProgressView()
                        .frame(width: 42, height: 42)
                } else if !vm.workouts.isEmpty {
                    Image(systemName: "line.3.horizontal.decrease.circle" + (vm.workoutType == nil && vm.workoutDate == nil ? "" : ".fill"))
                        .resizable()
                        .frame(width: 42, height: 42)
                }
            }.padding(.trailing, 320)
            .padding(.bottom, 100)
               /* if vm.recording {
                    Button {
                        showStopConfirmation = true
                    } label: {
                        Text("STOP")
                            .font(.system(size: 32, weight: .black))
                            .italic()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120)
                            .background(.black)
                            .cornerRadius(60)
                    }
                    .confirmationDialog("Stop Workout?", isPresented: $showStopConfirmation, titleVisibility: .visible) {
                        Button("Cancel", role: .cancel) {}
                        Button("Stop & Discard", role: .destructive) {
                            vm.discardWorkout()
                        }
                        Button("Finish & Save") {
                            Task {
                                await vm.endWorkout()
                            }
                        }
                    }
                } else {
//                    Button {
//                        Task {
//                            await vm.startWorkout(type: .running)
//                        }
//                    } label: {
//                        Text("Go")
//                            .font(.system(size: 32, weight: .black))
//                            .italic()
//                            .foregroundColor(.white)
//                            .frame(width: 120, height: 120)
//                            .background(.black)
//                            .cornerRadius(60)
//                    }
                   
                }*/
                     
        }
    }
    
    func updateTrackingMode() {
        var mode: MKUserTrackingMode {
            switch vm.trackingMode {
            case .none:
                return .follow
            case .follow:
                return .followWithHeading
            default:
                return .none
            }
        }
        
        //ViewModel의 updateTrackingMode() 함수를 호출하고 계산된 "mode" 변수를 전달합니다.
        vm.updateTrackingMode(mode)
    }
    
    var trackingModeImage: String {
        switch vm.trackingMode {
        case .none:
            return "location.circle"
        case .follow:
            return "location.circle.fill"
        default:
            return "location.north.line.fill"
        }
    }
    
    var mapTypeImage: String {
        switch vm.mapType {
        case .standard:
            return "globe.europe.africa.fill"
        default:
            return "map"
        }
    }
}

struct FloatingButtons_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButtons()
            .environmentObject(WorkoutViewModel())
    }
}
