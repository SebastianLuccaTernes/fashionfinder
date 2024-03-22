//
//  CostumButtons.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 18.03.24.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    var title: String
    var ButtonWidth: CGFloat
    var ButtonHeight: CGFloat
    var backgroundColor: Color // Add a new parameter for the background color
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // Gradient background
                backgroundColor
                .cornerRadius(0) // Rounded corners
                .shadow(color: .black.opacity(0.2), radius: 20, x: 20, y: 20) // Shadow effect Button
            
            // Button content
            Text(title)
                .font(.custom("ClashDisplay-Semibold", size: 16)) // Use custom font with size 20
                .foregroundColor((Color.black))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                //.shadow(color: .black.opacity(0.2), radius: 1, x: 5, y: 3) // Shadow Effect Text
        }
        .frame(width: ButtonWidth, height: ButtonHeight) // Sets the button size
        .cornerRadius(0) // Ensures the shadow matches the rounded corners
        .overlay( // Add an overlay for the stroke
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.black, lineWidth: 1)
            )
        .onTapGesture {
            action()
        }
            }
}
