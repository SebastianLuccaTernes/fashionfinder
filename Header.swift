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
                    .padding(.leading, 40)
            }
            Spacer()
                .padding(.leading, 100)
            .fullScreenCover(isPresented: $isPresented) {
                content()
            }
            Text("FINDr.".uppercased())
                .font(.custom("BaseNeueTrial-Regular", size: 36))
                .padding()
                .foregroundColor(.black)
                .font(.largeTitle)
                .bold()
                .padding(.leading, -255)
        }
    }
}

struct ContentPage: View {
    var body: some View {
        VStack {
            Header(content: { StartView() }) // Explicitly specify the closure type
            // Your page content here
        }
    }
}

    struct ContentPage_Previews: PreviewProvider {
        static var previews: some View {
            ContentPage()// Your page content here
            }
        }


