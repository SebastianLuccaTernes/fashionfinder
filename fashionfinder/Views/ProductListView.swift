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
  
                    
                    DraggableSheetView(content: ListViewCardContent())
                

                    Spacer()
                
            
            
            
        }
    }

// Content for the Slider
struct ListViewCardContent: CardContent {
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    

    
    var view: AnyView {
        AnyView(
            VStack {
                Text("Product 12344")
                    .padding(.top, 30)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 20) {
                        ForEach(0..<10) { index in
                            Image("Dog")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .padding()
                                .edgesIgnoringSafeArea(.all)
                        }
                        
                        
                    }

                }


            }


        )
        
    }
    
}


#Preview {
    ProductListView()
}
