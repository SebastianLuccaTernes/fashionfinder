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
                // Header = from Header.swift
                Header(content: { CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true)) }) // Explicitly specify the closure type
            }

            
            Spacer()
        }
                
            }
            
        
    }

#Preview {
    ProductListView()
}
