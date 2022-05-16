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
    
    var allImages : [Int]

    @State private var orientation = UIDeviceOrientation.unknown
    
    var demo = false
    
    let quoteCyclePeriod = 12.0
    
    let imageCyclePeriod = 24.0
    
    let demoQuote = "Morning Habits <br>Hydrate first sf sdf sdf sdf sdfsdf sdf sdf sf sdf sdf sd sd sdf<br>Exercise<br>Plan your day the night before<br>"
    
    @State var indexOfMotivation = 0
    
    @State var imageIndex = 1


    
    let imagePrefix = "fav - "

    var body: some View {
        let quoteTimer = Timer.publish(every: quoteCyclePeriod, on: .main, in: .common).autoconnect()
        
        ZStack (alignment: .leading) {
            BackgroundAnimationView(backGroundImage: imagePrefix + String(allImages[imageIndex-1]))
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
            if (imageIndex > allImages.count) {
                imageIndex = 1
            }
            
        }
        .onAppear() {

        }

    }

    
    

}

struct WisdomMotivationView_Previews: PreviewProvider {
    static var previews: some View {
        WisdomMotivationView(allItems: .constant([]), allImages: [8], demo: true )
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
        WisdomMotivationView(allItems: .constant([]), allImages: [8], demo: true)
            .preferredColorScheme(.light)
            
    }
}
