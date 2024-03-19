//
//  cropImageView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI

struct cropImageView: View {
    @Binding var selectedImage: UIImage?
   
    
    var body: some View {
        ZStack {// Hintergrundbild oder Farbe
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack { // Title und back taste
                    Text("Hi hier kommt Titel und back taste ".uppercased())
                        .padding()
                        
                }
                if let image = selectedImage { // if an image is picket it is shown here
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    let image = Image("Dog") // Picture Example
                       //Error handling @Sebastian?
                       

                }
                Spacer()
               
                
                
                
                
                
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
    cropImageView(selectedImage: .constant(UIImage(named: "Dog")))
}
