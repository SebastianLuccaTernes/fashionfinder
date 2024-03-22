//
//  Header.swift
//  fashionfinder
//
//  Created by Luca Stoke on 22.03.24.
//

import Foundation
import SwiftUI

struct Header<Content: View>: View {
    @State private var isPresented = false
    let content: () -> Content

    init(content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack {
            Button(action: {
                isPresented.toggle()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                .padding(.leading, 35)            }
            Spacer() // This Spacer pushes the Text to the center
            Text("FINDr.".uppercased())
                .font(.custom("BaseNeueTrial-Regular", size: 36))
                .padding(.leading, -39)
                .foregroundColor(.black)
                .font(.largeTitle)
                .bold()
            Spacer() // This Spacer ensures the Text is centered
        }
        .fullScreenCover(isPresented: $isPresented) {
            content()
        }
    }
}

struct ContentPage: View {
    var body: some View {
        VStack {
            Header(content: { StartView() }) // Explicitly specify the closure type
            // Your page content here
            Spacer()
        }
    }
}

    struct ContentPage_Previews: PreviewProvider {
        static var previews: some View {
            ContentPage()// Your page content here
            }
        }


