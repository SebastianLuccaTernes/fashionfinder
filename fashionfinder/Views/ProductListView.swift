//
//  productListView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI

struct ProductListView: View {
    @State private var isStartViewActive = false
    @State private var isCropViewActive = false

    var body: some View {
        VStack{
            
            HStack { // Title und back taste
                Button(action: {
                    // Toggle the state to show or hide the full screen cover
                    isCropViewActive.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(.leading, 40)

                }
                Spacer()
                    .padding(.leading, 100)
                // Attach the fullScreenCover modifier to a view that is always present
                .fullScreenCover(isPresented: $isCropViewActive) {
                    CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true))

                            
                }
                Text("FINDRIN.".uppercased())
                    .font(.custom("BaseNeueTrial-Regular", size: 36))
                    .padding()
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, -255)

                
                
            }

            
            Spacer()
        }
                
            }
            
        
    }

#Preview {
    ProductListView()
}
