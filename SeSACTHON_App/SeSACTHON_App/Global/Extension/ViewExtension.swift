//
//  ViewExtension.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import Foundation
import SwiftUI
import Alamofire

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    
    
    func fetchDangerList() -> [DangerInfoMO] {
        
        var dangerArr: [DangerInfoMO] = [
            .init(id: 1, uid: "testuid", latitude: 36.016, longitude: 129.324, picturePath: "/123.png", type: .step),
            .init(id: 2, uid: "testuid", latitude: 36.017, longitude: 129.325, picturePath: "/124.png", type: .slope),
            .init(id: 3, uid: "testuid", latitude: 36.018, longitude: 129.326, picturePath: "/125.png", type: .construction),
            .init(id: 4, uid: "testuid", latitude: 36.019, longitude: 129.327, picturePath: "/126.png", type: .narrow)
        ]
        
        dangerArr.removeAll()
        AF.request("http://35.72.228.224/adaStudy/dangerInfo.php")
        
            .responseDecodable(of: [DangerInfoMO].self) { response in
                guard let dangerInfoArray = response.value else {
                    print("Failed to decode dangerInfoArray")
                    return
                }
                print(response.value?.first?.latitude)
                dangerArr = response.value!
                print(dangerArr.description)
            }
        return dangerArr
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
 // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
