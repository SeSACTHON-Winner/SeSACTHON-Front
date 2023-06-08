//
//  PermissionView.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 14/02/2023.
//

import SwiftUI

struct PermissionsView: View {
    @EnvironmentObject var vm: WorkoutViewModel
    //ViewModel 객체는 EnvironmentObject에서 가져옵니다.
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section {
                        HStack(alignment: .top, spacing: 15) {
                            Image("healthIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5)
                                .padding(.top, 10)
                            PermissionRow(title: "Health", description: NAME + " needs access to your Health Data to show all your workout routes on one map and save the workouts you record.", allowed: vm.healthAuth, denied: vm.healthStatus == .sharingDenied, instructions: "Please go to Health > Sharing > Apps > \(NAME) and select \"Turn On All\"", linkTitle: "Health", linkString: "x-apple-health://", loading: vm.healthLoading, allowString: "Allow") {
                                Task {
                                    await vm.requestHealthAuthorisation() // 권한 요청이 ViewModel 객체에게 전송됩니다.
                                }
                            }
                        }
                    }
                    
                    Section {
                        HStack(alignment: .top, spacing: 15) {
                            Image(systemName: "location.fill")
                                .font(.title2)
                                .frame(width: 50, height: 50)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 10)
                            PermissionRow(title: "Location Always", description: NAME + " needs access to your location to record a workout route in the background and show your location on the map.", allowed: vm.locationAuth, denied: vm.locationStatus == .denied, instructions: "Please go to Settings > \(NAME) > Location and select \"Always\"", linkTitle: "Settings", linkString: UIApplication.openSettingsURLString, loading: false, allowString: vm.locationStatus == .notDetermined ? "Allow While Using" : "Allow Always") {
                                vm.requestLocationAuthorisation()
                            }
                        }
                    } footer: {
                        if vm.locationStatus == .authorizedWhenInUse {
                            Text("If the button above doesn't present a permission dialog, please go to Settings > \(NAME) > Location and select \"Always\"")
                        }
                    }
                    
                    Section {
                        HStack(alignment: .top, spacing: 15) {
                            Image(systemName: "scope")
                                .font(.title2.bold())
                                .frame(width: 50, height: 50)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 10)
                            PermissionRow(title: "Precise Location", description: NAME + " needs access to your precise location to track your workout routes more accurately.", allowed: vm.accuracyAuth, denied: true, instructions: "Please go to Settings > \(NAME) > Location and toggle \"Precise Location\" to ON", linkTitle: "Settings", linkString: UIApplication.openSettingsURLString, loading: false, allowString: "Allow") {
                                vm.requestLocationAuthorisation()
                            }
                        }
                    }
                }
                Button {
                    vm.showPermissionsView = false
                } label: {
                    Text("Get Started")
                        .bigButton()
                }
                .padding()
                .disabled(!vm.healthAuth || !vm.locationAuth || !vm.accuracyAuth)  //모든 권한이 허용되지 않은 경우 버튼이 비활성화됩니다.
            }
            .buttonStyle(.borderless)
            .navigationTitle("Need Permissions")
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled()
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                PermissionsView()
                    .environmentObject(WorkoutViewModel())  //ViewModel의 인스턴스가 여기에 environmentObject로 주입됩니다.
            }
    }
}

struct PermissionRow: View {
    @State var showAlert = false
    
    let title: String
    let description: String
    let allowed: Bool
    let denied: Bool
    let instructions: String
    let linkTitle: String
    let linkString: String
    let loading: Bool
    let allowString: String
    let request: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(description)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
            if loading {
                ProgressView()
                    .padding(.vertical, 5)
            } else {
                Button {
                    if denied {
                        showAlert = true //승인이 거부되면 버튼을 누르면 알림이 표시됩니다
                    } else {
                        request() //그렇지 않으면 request() 호출

                    }
                } label: {
                    Text(allowed ? "Allowed" : allowString)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.accentColor)
                        .font(.headline)
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                }
                .disabled(allowed)
            }
        }
        .padding(.vertical, 5)
        .alert("Allow Access", isPresented: $showAlert) {
            Button("Cancel") {}
            Button(linkTitle, role: .cancel) {
                if let url = URL(string: linkString) {
                    UIApplication.shared.open(url)
                }
            }
        } message: {
            Text(instructions)
        }
    }
}
