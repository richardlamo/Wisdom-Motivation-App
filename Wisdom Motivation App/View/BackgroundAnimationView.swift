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
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: backGroundImage ?? defaultBackground)!)
                .resizable()
                .scaledToFill()
 //               .frame(width : 500 ,height: 950, alignment: .center)
                .frame(width:UIScreen.main.bounds.width,
                       height:UIScreen.main.bounds.height,
                       alignment: .center)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                .clipped()
                
//            Canvas {
//                context, size in
//                let image = Image(systemName: "sparkle")
//                context.draw(image, at: CGPoint(x:0.5 * size.width, y:0.5 * size.height))
//            }
            
        }
        .animation(.easeIn(duration: 1))
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

