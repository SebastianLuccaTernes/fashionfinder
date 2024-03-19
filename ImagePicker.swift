//
//  ImagePicker.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 19.03.24.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI
import Combine


struct ImagePicker: UIViewControllerRepresentable { // protocol that bridges between Ui and Kit
    @Binding var sourceType: UIImagePickerController.SourceType // determines the source which the picker choose from
    @Binding var selectedImage: UIImage? // holds the image selected by the user @binding two way binding -> read and written from ImagePicker and parentView
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // is called when UIViewControllerRepresentable is initialized
        let picker = UIImagePickerController() // new instance of PickerController bind to picker var
        picker.delegate = context.coordinator
        // instance of imagePickerController class -> handels events user selecting image or canceling
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }// is called when SwiftUi view updates -> configured once doesnt nessecary be updated
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // bridge between imagePickerController and SwiftUi view
        var parent: ImagePicker // reference to ImagePicker struct. Allows the communicator to communicate back to ImagePicker -> updating based on user actions
        
        init(_ parent: ImagePicker) {
            self.parent = parent // crucial for the coordinator to update image Picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        } // is called when user selects image. Retrives Image from info dictionary and assigns to parent.selectedImage -> Updates ImagePicker and dismisses picker afterwards
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        } // dissmisses Image Picker when user cancels image picking process
    }
}
