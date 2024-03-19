//
//  cropImageView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI

struct cropImageView: View {
    
    
    var body: some View {
        ZStack {// Hintergrundbild oder Farbe
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack { // Title und back taste
                    Text("Hi hier kommt Titel und back taste ".uppercased())
                        .padding()
                        
                }
                Spacer()
               
                Image("Dog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 3)
                    )
                    .padding(20)

                
                
                
                
                Spacer() // Füllt den verfügbaren Raum und drückt den Button nach unten
                
                Button(action: {
                    print("Button gedrückt")
                }) {
                    Text("Find It")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.lavendel) // Buttonfarbe
                        .cornerRadius(10)
                }
            }
        }

    }
}

#Preview {
    cropImageView()
}
