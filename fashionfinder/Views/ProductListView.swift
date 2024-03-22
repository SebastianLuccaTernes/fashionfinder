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
    let image = Image("Dog")

    var body: some View {
        VStack{
            HStack { // Title und back taste
                Button(action: {
                    // Action to dismiss the fullScreenCover
                    isStartViewActive = true
                }) { Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .fullScreenCover(isPresented: $isStartViewActive) {
                            CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true))
                        }
                }
                Text("FINDr.".uppercased())
                    .padding()
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                
                
            }
            Spacer()
            
        }
    }
}

#Preview {
    ProductListView()
}
