//
//  QuotationDisplayView.swift
//  SwiftUIPrototype
//
//  Created by Richard Lam on 11/5/2022.
//

import SwiftUI

struct QuotationDisplayView: View {
    
    var author : String
    
    var quote : String
    
   

    var body: some View {
        let contents = generateTextFields(item: self.quote)

        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(contents, id: \.self) {
                    item in
                    Text("\(item)")
                        .padding(.top,2)
                        .padding(.bottom, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .font(.system(size: 28))
                        .foregroundStyle(Color("MotivationColors"))
                        .shadow(color: .black, radius: 4)

                }
                if let author = self.author {
                    Text("\(author)")
                        .padding(.leading, 250)
                        .font(.system(size: 20))
                        .foregroundStyle(Color("MotivationColors"))
                        .shadow(color: .black, radius: 7)
                }
            }
            .animation(.easeInOut(duration: 2))
        }

    }
    
    func generateTextFields(item : String) -> [String] {
        let fields: [String] = item.components(separatedBy: "<br>")  as [String]
        return fields
    }
}

struct QuotationDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        let demoQuote = "Morning Habits <br>Hydrate first<br>Exercise<br>Plan your day the night before<br>"
        QuotationDisplayView(author: "Ian Fleming", quote: demoQuote)
    }
}
