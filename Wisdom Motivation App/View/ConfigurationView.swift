//
//  ConfigurationView.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 1/8/2022.
//

import SwiftUI

struct ConfigurationView: View {
    @State private var isSettingPresenting = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack() {
                Spacer()
                Button(action: {
                    isSettingPresenting.toggle()
                }) {
                    Image(systemName: "gear")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 40.0, height: 40.0)
                        .padding()
                }
                .padding(10)
                .fullScreenCover(isPresented: $isSettingPresenting, content: {
                    ListConfigurationsView()
                        .overlay(alignment: .topTrailing) {
                            Button {
                                isSettingPresenting = false
                            } label: {
                                Text("Done", comment: "Button to dismiss the settings.")
                            }.padding()
                            Spacer()
                        }
                })

            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
