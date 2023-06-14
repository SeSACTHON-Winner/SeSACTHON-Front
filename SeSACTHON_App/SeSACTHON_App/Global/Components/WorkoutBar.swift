//
//  WorkoutBar.swift
//  Running
//
//  Created by JinheeLee on 15/01/2023.
//

import SwiftUI
import MapKit

struct WorkoutBar: View {
    @EnvironmentObject var vm: WorkoutViewModel
    @State var showWorkoutView = false
    @State var offset = Double.zero
    @Binding var time: TimeInterval
    let workout: Workout
    let new: Bool
    
    @Binding var helpCount: Int

    var body: some View {

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    WorkoutStat(name: "거리", value: Measurement(value: workout.distance, unit: UnitLength.meters).formatted())//포맷된 거리를 표시합니다.
                    Spacer()
                    WorkoutStat(name: "페이스", value: formatPace()) // 포맷된 속도를 표시합니다.
                    Spacer()
                    WorkoutStat(name: "칼로리", value: workout.calories.formatted())
                    // WorkoutStat(name: "Elevation", value: Measurement(value: workout.elevation, unit: UnitLength.meters).formatted())// 포맷된 고도를 표시합니다.
                    Spacer()
                    //TODO: 도움개수 연결
                    WorkoutStat(name: "도움개수", value: helpCount.formatted())

                }
            }
            .padding(.horizontal, 12).padding(.bottom, 8)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .onTapGesture {
                vm.zoomTo(workout)
            }
            .if(!new) { $0
                .offset(x: 0, y: offset)
                .opacity((100 - offset)/100)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if value.translation.height > 0 {
                            offset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.predictedEndTranslation.height > 50 {
                            vm.selectedWorkout = nil // 훈련이 임계값을 초과하는 경우 훈련을 무시합니다.
                        } else {
                            withAnimation(.spring()) {
                                offset = 0 // 스와이프 제스처 종료 시 오프셋을 재설정합니다.
                            }
                        }
                    }
                )
            }
    }
    
    func formatPace() -> String {
        let seconds = workout.duration * 1000 / workout.distance
        
        if seconds.isFinite {
            let minutes = Int(seconds / 60)
            let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
            return "\(minutes)'\(remainingSeconds)\""
        } else {
            return "0\'0\""
        }
    }
}
//
//
//struct WorkoutBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Map(mapRect: .constant(MKMapRect()))
//            WorkoutBar(time: $time, workout: .example, new: true)
//                .environmentObject(WorkoutViewModel())
//        }
//    }
//}

struct WorkoutStat: View {
    let name: String
    let value: String
    
    var body: some View {
        VStack(spacing: 3) {
            Text(name)
                .font(.system(size: 12, weight: .light)).italic()
                .foregroundColor(.white).opacity(0.7)
            Text(value)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold)).italic()
        }.frame(width: 80)
    }
}
