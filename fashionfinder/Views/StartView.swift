//
//  startView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI
import PhotosUI
import Combine
import UIKit

// PREVIEW//
struct StartView: View {
    @State private var showImagePicker = false // Image picker is not shown to user
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary // determines the source from which the picker will select images
    @State private var selectedImage: UIImage? // once a image is selected it is here stored
    @State private var showCropImageView = false // defines if CropImageView should be seen or not
    
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
                        HStack {
                            Text("Fashion")
                                .font(.custom("BaseNeueTrial-Regular", size: 40))
                            //.fontWeight(.light)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 59.0)
                                .padding(.leading, 40.0)
                            Text("FINDR.")
                                .font(.custom("BaseNeueTrial-Bold", size: 40)) // Replace "AnotherFontName" with the actual name of the second font
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 60.0)
                                .padding(.leading, -5.0)
                        }
                        
                        
                            Text("See It")
                                .font(.custom("BaseNeueTrial-Regular", size: 24))
                                //.fontWeight(.light)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, -20.0)
                                .padding(.leading, -104.0)
                        Text("find it")
                                .font(.custom("BaseNeueTrial-Regular", size: 24))
                                //.fontWeight(.light)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, -10.0)
                                .padding(.leading, -70.0)
                            Text("buy it")
                                .font(.custom("BaseNeueTrial-Regular", size: 24))
                                //.fontWeight(.light)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, -10.0)
                                .padding(.leading)
                        
                    }
                    
                    Spacer ()
                }
                Spacer ()
                VStack {
                    CustomButton(title: "Upload Image", ButtonWidth: 300, ButtonHeight: 50, backgroundColor: Color.black) {
                        self.sourceType = .photoLibrary // Action closure -> picker should access libray
                        self.showImagePicker = true // activates Image Picker
                    }
                    // Free Space
                    .padding(5)
                    // ---
                    CustomButton(title: "Take Photo", ButtonWidth: 300, ButtonHeight: 50, backgroundColor: Color.black) {
                        self.sourceType = .camera // Action closure -> picker should access camera
                        self.showImagePicker = true // activates Image Picker
                    }
                }
                .padding(.bottom, 80.0)
                .sheet(isPresented: $showImagePicker) { 
                    // if showImagePicker = true -> sheet is presented
                    ImagePicker(sourceType: $sourceType, selectedImage: $selectedImage)
                    // content of the sheet view / instance of imagePicker
                    /* sourceType: $sourceType = determines the source of the image picker (.libray
                     or camera
                     selectedImage: $selectedImage = stores the image selected by the user */
                }
                .fullScreenCover(isPresented: $showCropImageView) { 
                    // if called shows fullscreen view
                    if selectedImage != nil {
                        // Check if an image has been selected
                        CropImageView(selectedImage: $selectedImage, showCropImageView: $showCropImageView)
                        // If an image is selected, present to cropImageView with the selected image
                    }
                }
                .onChange(of: selectedImage) { _ in showCropImageView = true
                    /*When the selectedImage changes, set showCropImageView to true
                     This triggers the fullScreenCover to be presented*/
                }
            }
        }
    }
}





// PREVIEW//
#Preview {
    StartView()
}



