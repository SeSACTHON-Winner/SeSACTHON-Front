//
//  PlaceAnnotationView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI
import Alamofire
import Kingfisher

struct PlaceAnnotationView: View {
    
    
    let danger: DangerInfoGroup
    var slopeCount: Int
    var stepCount: Int
    var constructionCount: Int
    var narrowCount: Int
    let listLength: Int
    @State var dotClick = false
    @State var picturePath: String?
    
    init(danger: DangerInfoGroup) {
        self.danger = danger
        self.listLength = danger.list.count
        self.slopeCount = 0
        self.stepCount = 0
        self.narrowCount = 0
        self.constructionCount = 0
        self.picturePath = danger.list.first?.picturePath ?? "images/test1.jpg"
        print("Danger list count: \(danger.list.count)")
        if let firstPicturePath = danger.list.first?.picturePath {
            print("First picture path: \(firstPicturePath)")
            self.picturePath = danger.list.first?.picturePath
            PicturePath.picturePath = danger.list.first?.picturePath ?? "images/test1.jpg"
            print("PicturePath.picturePath : \(PicturePath.picturePath)")
            print("Danger list count: \(danger.list.count)")
        } else {
            print("First picture path is nil")
            
        }
        print("Assigned picture path: \(self.picturePath)")
        print("Assigned picture path: \(self.picturePath)")
        
        for i in danger.list {
            switch i.type {
            case "slope":
                slopeCount += 1
            case "step":
                stepCount += 1
            case "construction":
                constructionCount += 1
            case "narrow":
                narrowCount += 1
            default:
                continue
            }
        }
    }
    
    func calWidth() -> Int{
        var returnValue = 0
        if slopeCount > 0 {
            returnValue += 1
        }
        if stepCount > 0 {
            returnValue += 1
        }
        if narrowCount > 0 {
            returnValue += 1
        }
        if constructionCount > 0 {
            returnValue += 1
        }
        print(returnValue)
        return returnValue
    }
    
    var body: some View {
        VStack(spacing: 0) {

            KFImage(URL(string: "http://35.72.228.224/sesacthon/\(PicturePath.picturePath)")!)
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
            if dotClick {                
            Color.white
                .frame(width: 50 * CGFloat(calWidth()), height: 80)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        if slopeCount > 0 {
                            VStack{
                                Image("icon_slope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32)
                                Text("\(slopeCount)")
                                    .foregroundColor(.black)
                            }
                            if stepCount > 0 {
                                VStack{
                                    Image("icon_step")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 32)
                                    Text("\(stepCount)")
                                        .foregroundColor(.black)
                                }
                            }
                            if constructionCount > 0 {
                                VStack{
                                    Image("icon_construction")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 32)
                                    Text("\(constructionCount)")
                                        .foregroundColor(.black)
                                }
                            }
                            if narrowCount > 0 {
                                VStack{
                                    Image("icon_narrow")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 32)
                                    Text("\(narrowCount)")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }        
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .scaleEffect(2)
                    .foregroundColor(.white)
            }
            else{
                Spacer().frame(width:0, height: 90)
            }

                    //.shadow(radius: 2, x: 2, y: 2)
                }
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .scaleEffect(2)
                .foregroundColor(.white)
        }

            
            Image("dangerDot")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .overlay{
                    Text("\(slopeCount + stepCount + constructionCount + narrowCount)")
                        .frame(height: 32)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    self.dotClick.toggle()
                }
        }
    }
}


//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}


class PicturePath {
    static var picturePath = ""
}
