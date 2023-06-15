//
//  RootView.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 19/02/2023.
//


import SwiftUI
import CoreLocation

import MapKit

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var vm: WorkoutViewModel

    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    @Binding var swpSelection: Int

    @Binding var region : MKCoordinateRegion
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(region: $region)
                .ignoresSafeArea()
                .tint(.sesacMint)
            VStack{
                Spacer()
                
                if swpSelection == 2 {
                    //FloatingButtons()
                }
            }
            .padding(10)
        }
        .animation(.default, value: vm.recording)  //기록 변경 사항을 애니메이션으로 표시합니다.
        .animation(.default, value: vm.selectedWorkout) // 선택한 운동에 대한 변경 사항을 애니메이션으로 표시합니다.
        .alert(vm.error.rawValue, isPresented: $vm.showErrorAlert) {} message: { //에러 메시지와 함께 경고창을 표시합니다.
            Text(vm.error.message)
        }
        .onAppear { // 첫 번째 실행 시 환영 메시지와 InfoView를 표시
            if !launchedBefore {
                launchedBefore = true
                welcome = true
                vm.showInfoView = true
                vm.showRunListView = false
            }
        }
        .fullScreenCover(isPresented: $vm.healthUnavailable) { // 건강 데이터 접근이 불가능한 경우 ErrorView를 표시합니다.
            ErrorView(systemName: "heart.slash", title: "Health Unavailable", message: "\(NAME) needs access to the Health App to store and load workouts. Unfortunately, this device does not have these capabilities so the app will not work.")
        }
        .sheet(isPresented: $vm.showInfoView, onDismiss: {
            welcome = false
        }) {
            InfoView(welcome: welcome)
        }
        
        .fullScreenCover(isPresented: $vm.showRunListView, onDismiss: {
            vm.showRunListView = false
        }, content: {
            ProfileView()
        })
        
        //.sheet(isPresented: $vm.showRunListView) {
            //RunListView()
         //   ProfileView()
        //}
        

        .sheet(isPresented: $vm.showPermissionsView) { // PermissionsView를 시트 형태로 표시합니다.
            PermissionsView()
        }
        .onChange(of: scenePhase) { newPhase in // scenePhase의 변화에 따라 HealthStatus를 업데이트합니다.
            if newPhase == .active {
                vm.updateHealthStatus()
            }
        }
        //.environmentObject(vm) // ViewModel을 환경 객체로 설정합니다.
    }
}


struct ErrorView: View {
    let systemName: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: systemName) // 에러 이미지
                .font(.system(size: 40))
                .foregroundColor(.secondary)
            VStack(spacing: 5) {
                Text(title) //에러 타이틀
                    .font(.title3.bold())
                Text(message) // 에러 메시지
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
