//
//  TesterView.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 13/5/2022.
//

import SwiftUI

struct TesterView: View {
    @State private var opacity = 0.5

    var body: some View {
        VStack {
            Text("Now you see me")
                .padding()
                .background(.red)
                .opacity(opacity)

            Slider(value: $opacity, in: 0...1)
                .padding()
        }
    }
}

struct TesterView_Previews: PreviewProvider {
    static var previews: some View {
        TesterView()
    }
}
