//
//  productListView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI

struct ProductListView: View {
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var isStartViewActive = false
    @State private var isCropViewActive = false
    @State private var showProductListSheet = false
    @State private var sliderHeight: CGFloat = 200
    
    var body: some View {
        VStack{
            
            HStack { // Title und back taste
                // Header = from Header.swift
                Header(content: { CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true)) }) // Explicitly specify the closure type
            }
            Spacer()
        }
        GeometryReader { geometry in
            VStack {
                // Slider
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: sliderHeight)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newHeight = sliderHeight + value.translation.height
                                if newHeight >= 0 && newHeight <= geometry.size.height {
                                    sliderHeight = newHeight
                                }
                            }
                    )
                
                
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(0..<10) { index in
                                Image("Dog")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .padding()
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    Spacer()
                
                
            }
            
        }
    }
}
#Preview {
    ProductListView()
}
