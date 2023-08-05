//
//  BackgroundAnimationView.swift
//  SwiftUIPrototype
//
//  Created by Richard Lam on 5/5/2022.
//

import SwiftUI

struct BackgroundAnimationView: View {
    
    var backGroundImage : String?
    
    let defaultBackground = "fav - 18"
    
    @State private var deviceWidth = UIScreen.main.bounds.width
    
    @State private var deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: backGroundImage ?? defaultBackground)!)
                .resizable()
                .scaledToFill()
                .frame(width: deviceWidth,
                       height: deviceHeight,
                       alignment: .center)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            
        }
        .animation(.easeIn(duration: 1))
        .onRotate {
            newOrientation in
                self.deviceWidth = UIScreen.main.bounds.width
                self.deviceHeight = UIScreen.main.bounds.height
        }
    }
}

struct BackgroundAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimationView()
            .previewInterfaceOrientation(.landscapeRight)
            .preferredColorScheme(.dark)
        BackgroundAnimationView()
            .previewInterfaceOrientation(.portrait)
            .preferredColorScheme(.dark)
    }
}

