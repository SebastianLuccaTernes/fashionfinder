//
//  ContentView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 06.03.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
            Image("yourImageName")
                .resizable()
                .scaledToFit()
            Button(action: {
                // Aktion für Button 1
            }) {
                Text("Button 1")
            }
            Button(action: {
                // Aktion für Button 2
            }) {
                Text("Button 2")
                    
                
            }
            
            HStack {
                Button(action: {
                }) {
                    Text("Button A")
                        .padding(.top)
                }
                Button(action: {
                }) {
                    Text("Button A")
                        .padding([.top, .leading], 13.0)
                        
                }
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        Text("FashionFinder")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
