//
//  WisdomMotivationView.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 11/5/2022.
//

import SwiftUI

struct WisdomMotivationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var allItems : [Motivation]
    
    var demo = false
    
    let quoteCyclePeriod = 12.0
    
    let imageCyclePeriod = 24.0
    
    let demoQuote = "Morning Habits <br>Hydrate first<br>Exercise<br>Plan your day the night before<br>"
    
    @State var indexOfMotivation = 0
    
    @State var imageIndex = 1

    let maxImageIndex = 19
    
    let imagePrefix = "fav - "

    var body: some View {
        let quoteTimer = Timer.publish(every: quoteCyclePeriod, on: .main, in: .common).autoconnect()
        
//        let backgroundTimer = Timer.publish(every: imageCyclePeriod, on: .main, in: .common).autoconnect()

        
        ZStack (alignment: .leading) {
            BackgroundAnimationView(backGroundImage: imagePrefix + String(imageIndex))
            if !allItems.isEmpty {
                let itemAuthor = allItems[indexOfMotivation].author
                let itemContent = allItems[indexOfMotivation].content
                if (!demo) {
                    QuotationDisplayView(author: itemAuthor ?? "Author", quote:  itemContent ?? "Quote")
                } else {
                    QuotationDisplayView(author: "Author", quote:  demoQuote)
                }
            } else {
                QuotationDisplayView(author: "Author", quote:  demoQuote)
            }
        }.gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
            .onEnded { value in
                        let horizontalAmount = value.translation.width as CGFloat
                        let verticalAmount = value.translation.height as CGFloat
                        
                        if abs(horizontalAmount) > abs(verticalAmount) {
                            if horizontalAmount < 0 {
                                indexOfMotivation += 1
                                if indexOfMotivation > allItems.count-1 {
                                    indexOfMotivation = 0
                                }
                            } else {
                                indexOfMotivation -= 1
                                if indexOfMotivation < 0 {
                                    indexOfMotivation = allItems.count-1
                                }
                            }

                        }
                    }
            )
        .onReceive(quoteTimer) {
            time in
            indexOfMotivation += 1
            if indexOfMotivation > allItems.count-1 {
                indexOfMotivation = 0
            }
            imageIndex += 1
            print("Image \(imageIndex)")
            if imageIndex > maxImageIndex {
                imageIndex = 1
            }
            
        }

        .onAppear() {

        }
    }

    
    

}

struct WisdomMotivationView_Previews: PreviewProvider {
    static var previews: some View {
        WisdomMotivationView(allItems: .constant([]), demo: true )
            .preferredColorScheme(.dark)
        WisdomMotivationView(allItems: .constant([]), demo: true)
            .preferredColorScheme(.light)
            
    }
}
