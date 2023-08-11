//
//  QuotationDisplayView.swift
//  SwiftUIPrototype
//
//  Created by Richard Lam on 11/5/2022.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}



struct QuotationDisplayView: View {
    
    var author : String
    
    var quote : String
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    @State private var deviceWidth = UIScreen.main.bounds.width
    
    @State private var deviceHeight = UIScreen.main.bounds.height

    var body: some View {
        let contents = generateTextFields(item: self.quote)

        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(contents, id: \.self) {
                    item in
                    Text("\(item)")
                        .padding(.top,2)
                        .padding(.bottom, 2)
                        .padding(.leading, 35)
                        .padding(.trailing, 35)
                        .font(.system(size: 30))
                        .foregroundStyle(Color("MotivationColors"))
                        .shadow(color: .black, radius: 6)

                }
                let author =
                    Text("\(author)")
                        .padding(.leading, 180)
                        .font(.system(size: 22))
                        .foregroundStyle(Color("MotivationColors"))
                        .shadow(color: .black, radius: 8)
                
            }
            .animation(.easeInOut(duration: 1.5))
            .frame(width:deviceWidth,
                   height:deviceHeight,
                   alignment: .center)
        }
        .onRotate {
            newOrientation in
                orientation = newOrientation
                self.deviceWidth = UIScreen.main.bounds.width
                self.deviceHeight = UIScreen.main.bounds.height
        }

    }
    
    func generateTextFields(item : String) -> [String] {
        let fields: [String] = item.components(separatedBy: "<br>")  as [String]
        return fields
    }
}

struct QuotationDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        let demoQuote = "Morning Habits  sfdsfsdfsdfsdfsdfsd sdfsd sdfsdfs sdfsdfsdf sfd sdfs df sdf sdf sdf sdfsdfsd<br>Hydrate first<br>Exercise<br>Plan your day the night before<br>"
        QuotationDisplayView(author: "Arnold Schwarzenegger", quote: demoQuote)
            .previewInterfaceOrientation(.portraitUpsideDown)
        QuotationDisplayView(author: "Arnold Schwarzenegger", quote: demoQuote)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
