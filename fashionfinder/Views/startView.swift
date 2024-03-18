//
//  startView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI


// Custom Button
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
                .font(.headline)
                .foregroundColor((Color.black))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 5, y: 3) // Shadow Effect Text
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


// Extension to use Hex Codes. //
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


// PREVIEW//
struct startView: View {
    var body: some View {
        ZStack {
            // Background
            Image("WomenJump") // Start Page Background Image
                .resizable() // Makes the image resizable
                .aspectRatio(contentMode: .fill) // Sets the content mode to fit the image within the view's bounds
                .edgesIgnoringSafeArea(.all) // To fill the full Screen
            
            VStack {
                HStack {
                    VStack {
                        // Logo Text!
                        Text("FashionFINDR")
                            .font(.system(size: 40)) // Adjust the size as needed
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 60.0)
                            .padding(.leading, 40.0)
                            
                            
                        
                        
                        Text("See it Find It Buy It")
                            .font(.system(size: 24)) // Adjust the size as needed
                            .fontWeight(.thin)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -40.0)
                        
                    }
                    
                    Spacer ()
                }
                Spacer ()

                
                // Add Image Button
                CustomButton(title: "Add Image", ButtonWidth: 300, ButtonHeight: 50, backgroundColor: Color(hex: "#DFC5FE")) {
                }
                .padding(.bottom, 80.0)
                
            }
        }

    }
}


// PREVIEW//
#Preview {
    startView()
}
