//
//  SplashScreenView.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 23.03.24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var findrTextOffset = UIScreen.main.bounds.width // Start off-screen to the right
    
    var body: some View {
        if isActive {
            StartView()
        } else {
            VStack { // Use VStack for centering content
                HStack(spacing: 0.1) {
                    Text("Fashion")
                        .font(.custom("BaseNeueTrial-Light", size: 26))
                        .foregroundColor(.white) // Make text color white

                    Text("FINDR.")
                        .font(.custom("BaseNeueTrial-Extrabold", size: 26))
                        .foregroundColor(.white) // Make text color white
                        .bold()
                        .fontWeight(.bold)
                        .offset(x: findrTextOffset, y: 0) // Apply the horizontal offset
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.2)) {
                                self.findrTextOffset = 0 // Animate to the intended position
                            }
                        }
                }
                .scaleEffect(size)
                .opacity(opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make VStack fill the entire screen
            .background(Color.black) // Set the background color of the entire view to black
            .edgesIgnoringSafeArea(.all) // Make the background extend to the edges of the screen
            .onAppear {
                withAnimation(.easeIn(duration: 2)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                   withAnimation(.easeInOut(duration: 1.8)) { // Slow down the transition
                                       self.isActive = true
                                   }
                               }
            }
        }
    }
}



#Preview {
    SplashScreenView()
}
