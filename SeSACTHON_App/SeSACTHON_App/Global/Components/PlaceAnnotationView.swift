//
//  PlaceAnnotationView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI
import Kingfisher

struct PlaceAnnotationView: View {

    
    let danger: DangerInfoGroup
    var slopeCount: Int
    var stepCount: Int
    var constructionCount: Int
    var narrowCount: Int
    let listLength: Int
    @State var picturePath: String?
    @State var dotClick = false
    var imageMainList = [Image("icon_slope_main"), Image("icon_step_main"), Image("icon_narrow_main"), Image("icon_construction_main")]

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
    
//    func calWidth() -> Int{
//        var returnValue = 0
//        if slopeCount > 0 {
//            returnValue += 1
//        }
//        if stepCount > 0 {
//            returnValue += 1
//        }
//        if narrowCount > 0 {
//            returnValue += 1
//        }
//        if constructionCount > 0 {
//            returnValue += 1
//        }
//        print(returnValue)
//        return returnValue
//    }
    
    func calMain() -> Image{
        var count = 0
        var select = 0
        if slopeCount >=  count {
            count = slopeCount
            select = 0
        }
        if stepCount >= count {
            count = stepCount
            select = 1
        }
        if narrowCount >= count {
            count = narrowCount
            select = 2
        }
        if constructionCount >= count {
            count = constructionCount
            select = 3
        }
        
        return imageMainList[select]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            if dotClick {
                VStack{
                    Color.white
                        .frame(width: 200, height: 250)
                        .cornerRadius(10)
                        .overlay {
                            VStack{
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
                                    .frame(width: 150, height: 150)
                                    .background(.black)
                                    .cornerRadius(5)
                                
                                HStack {
                                    if slopeCount > 0 {
                                        VStack{
                                            Image("icon_slope")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30)
                                            Text("\(slopeCount)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    if stepCount > 0 {
                                        VStack{
                                            Image("icon_step")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 30)
                                            Text("\(stepCount)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    if constructionCount > 0 {
                                        VStack{
                                            Image("icon_construction")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 30)
                                            Text("\(constructionCount)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    if narrowCount > 0 {
                                        VStack{
                                            Image("icon_narrow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 30)
                                            Text("\(narrowCount)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                        }
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.caption)
                        .scaleEffect(2)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    dotClick.toggle()
                }
                
            }
            
            
            calMain()
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .onTapGesture {
                    dotClick.toggle()
                }
                
            
            
        }
        if dotClick {
            Spacer().frame(width: 0, height: 260)
        }

    }
}



class PicturePath {
    static var picturePath = ""
}
