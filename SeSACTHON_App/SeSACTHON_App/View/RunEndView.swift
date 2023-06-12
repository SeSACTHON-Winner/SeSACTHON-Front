//
//  RunEndView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/03.
//

import SwiftUI
import Kingfisher
import Alamofire

struct RunEndView: View {
    @Binding var swpSelection: Int
    @State var courseName: String = ""
    @State var runningArr: [RunningInfo] = []
    @EnvironmentObject var vm: WorkoutViewModel
    var workout: Workout

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Spacer().frame(height: 60)
                    TopProfileView(title: "FINISH")
                        .foregroundColor(.blue)
                    Spacer()
                    HStack(alignment: .center) {
                        Text(formatDate(workout.date))
                            .font(.system(size: 16, weight: .medium))
                        .multilineTextAlignment(.center)
                        
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            //Text("15.1km")
                            Text("\(Measurement(value: workout.distance, unit: UnitLength.meters).formatted())")
                                .font(.system(size: 64, weight: .black)).italic()
                                .frame(alignment: .leading)
                                .foregroundColor(Color("MainColor"))
                                .onAppear {
                                    print((Measurement(value: workout.distance, unit: UnitLength.meters).converted(to: UnitLength.kilometers)))
                                } //TODO: 코드 분석,,
                            
                            HStack(spacing: 20) {
                                Text("시간")
                                    .font(.system(size: 12, weight: .medium))
                                    .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.white.opacity(0.6))

                                //Text("14:13:22")
                                Text("\(formatDuration(workout.duration))")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                //TODO: 칼로리 잘 받아오나 확인
                                Text("소모 칼로리")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.6))
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 60, alignment: .leading)
                                Text("\(Measurement(value: workout.calories, unit: UnitEnergy.kilocalories).formatted())")
                                    .font(.system(size: 24, weight: .bold)).italic()
                                Text("\(Measurement(value: workout.calories, unit: UnitEnergy.calories).formatted())")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("평균 페이스")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.white.opacity(0.6))

                                //TODO: Text("6’12”") 수정
                                Text("\(formatPace())")
                                    .font(.system(size: 24, weight: .bold)).italic()
                                Text("\(Measurement(value: workout.pace, unit: UnitSpeed.kilometersPerHour).formatted())")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("도움 개수")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.white.opacity(0.6))

                                Text("0")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("총 도움")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.white.opacity(0.6))

                                
                                Text("0")
                                    .font(.system(size: 24, weight: .bold)).italic()
                                    .foregroundColor(Color("MainColor"))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text("시작 - \(workout.date.formattedApple())")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                    }
                    TextField("코스 이름을 입력해주세요", text: $courseName)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.bottom, 26)
                }
                .padding(.horizontal, 28)
                .foregroundColor(.white)
                .frame(maxHeight: 580)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
                Spacer()
                VStack (alignment: .center){
                    HStack {
                        Text("최근 활동")
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                    }
                    .padding(.vertical, 12)
                       
                    ForEach(runningArr, id: \.self) { runninginfo in
                        RunRecentView(runData: runninginfo)
                    }
                } .padding(.leading, 24)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetchRunningInfo { result in
                switch result {
                case .success(let data):
                    runningArr = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월 d일"
            return dateFormatter.string(from: date)
    }
    func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        if let formattedDuration = formatter.string(from: duration) {
            return formattedDuration
        } else {
            return ""
        }
    }
    func formatPace() -> String {
        let seconds = workout.duration * 1000 / workout.distance
        
        if seconds.isFinite {
            let minutes = Int(seconds / 60)
            let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
            return "\(minutes)'\(remainingSeconds)\""
        } else {
            return "Invalid Pace"
        }
    }
}

extension RunEndView {
    func fetchRunningInfo(completion: @escaping (Result<[RunningInfo], AFError>) -> Void) {
        
        let url = "http://35.72.228.224/sesacthon/runningInfo.php"
        let params = ["uid" : UserDefaults.standard.string(forKey: "uid")] as Dictionary
        
        AF.request(url, method: .get, parameters: params)
            .responseDecodable(of: [RunningInfo].self) {
                completion($0.result)
                print($0.result)
            }
    }
}


struct RunRecentView: View {
    
    @State var runData: RunningInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                // MARK: - Image 교체
                KFImage(URL(string: "http://35.72.228.224/sesacthon/\(runData.picturePath)")!)
                    .placeholder { //플레이스 홀더 설정
                        Image(systemName: "map")
                    }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                    .onSuccess {r in //성공
                        print("succes: \(r)")
                    }
                    .onFailure { e in //실패
                        print("failure: \(e)")
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .background(.black)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 8){
                    Text(runData.date)
                        .font(.system(size: 12, weight: .medium)).opacity(0.3)
                    Text(runData.runningName)
                        .font(.system(size: 14, weight: .medium)).opacity(0.5)
                }
                Spacer()
                
            }
            HStack(spacing: 26.0) {
                VStack(alignment: .leading, spacing: 14) {
                    Text(String(format: "%.2f", runData.distance))
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Km")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text(runData.time)
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Time")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("\(runData.cal)")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Kcal")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("\(runData.helpCount)")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("도움")
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
        .padding(20)
        .background(Color("ListBackgroundColor"))
        .cornerRadius(14)
        .padding(.horizontal, 24)
        .frame(height: 148)
        .frame(maxWidth: .infinity)
        .shadow(radius: 4, x: 2, y: 2)
        .padding(.bottom, 20)
    }
}

struct RunEndView_Previews: PreviewProvider {
    static var previews: some View {
        RunEndView(swpSelection: .constant(2), workout: .example)
    }
}
