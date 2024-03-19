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
struct startView: View {
    @State private var showImagePicker = false // Image picker is not shown to user
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary // determines the source from which the picker will select images
    @State private var selectedImage: UIImage? // once a image is selected it is here stored
    
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
                HStack {
                    CustomButton(title: "Gallery", ButtonWidth: 150, ButtonHeight: 50, backgroundColor: Color.lavendel) {
                        self.sourceType = .photoLibrary // Action closure -> picker should access libray
                        self.showImagePicker = true // activates Image Picker
                    }
                    CustomButton(title: "Camera", ButtonWidth: 150, ButtonHeight: 50, backgroundColor: Color.lavendel) {
                        self.sourceType = .camera // Action closure -> picker should access camera
                        self.showImagePicker = true // activates Image Picker
                    }
                }
                .padding(.bottom, 80.0)
                .sheet(isPresented: $showImagePicker) { 
                    // if showImagePicker = true -> sheet is presented
                    ImagePicker(sourceType: $sourceType, selectedImage: $selectedImage)
                    // content of the sheet view / instance of imagePicker
                    /* sourceType: $sourceType = determines the source of the image picker (.libray or camera
                     selectedImage: $selectedImage = stores the image selected by the user */
                }
            }
        }

    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
       
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// PREVIEW//
#Preview {
    startView()
}
