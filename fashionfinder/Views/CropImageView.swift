//
//  cropImageView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI
import TOCropViewController

struct CropImageView: View {
    @Binding var selectedImage: UIImage?
    @Binding var showCropImageView: Bool
    @State private var isStartViewActive = false
    @State private var isCropViewActive = false
    @State private var showProductListSheet = false
    
    
    var body: some View {
        ZStack {// Hintergrundbild oder Farbe
            Color.clear
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack { // Title und back taste
                    // Header = See Header.swift
                    Header(content: { StartView() }) // Explicitly specify the closure type
                }
                
                if let image = selectedImage { // if an image is picked it is shown here
                    GeometryReader { geometry in
                        // Create a black background rectangle
                        Rectangle()
                            .fill(Color.greyF)
                            .frame(width: 300, height: 500 * 9 / 16) // Match the frame size with the image
                            .overlay(
                                Image(uiImage: image) // Overlay the image on top of the black rectangle
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                            .border(Color.black, width: 1) // Set the border around the black rectangle
                            .padding(.leading, 47)
                            .padding(.top, 47)
                            .clipShape(Rectangle()) // Clip the entire composition to a rectangle shape
                    }

                            .onTapGesture {
                                self.isCropViewActive = true //activates Cropping sheet
                            }
                    
                } else {
                    Rectangle()
                        .fill(Color.greyF)
                        .frame(width: 300, height: 500 * 9 / 16) // Match the frame size with the image
                        .overlay(
                            Image("Dog") // Overlay the image on top of the black rectangle
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        )
                        .border(Color.black, width: 1) // Set the border around the black rectangle
                        .padding(.leading)
                        .padding(.top, 47)
                        .clipShape(Rectangle()) // Clip the entire composition to a rectangle shape
                

                        .onTapGesture {
                            self.isCropViewActive = true //activates Cropping sheet
                        }
                    
                }
                Spacer()
                
                Spacer() // Füllt den verfügbaren Raum und drückt den Button nach unten
                
                CustomButton(title: "Find It", ButtonWidth: 150, ButtonHeight: 50, backgroundColor: Color.black) {
                    self.isCropViewActive = false // Close the crop view if it's open
                    self.showProductListSheet = true // Show the slider view
                }
            }
            .sheet(isPresented: $isCropViewActive) {
                TOCropViewWrapper(selectedImage: $selectedImage, isActive: $isCropViewActive)
            }

            
            }
            
            .fullScreenCover(isPresented: $showProductListSheet) {
                DraggableSheetView(content: ListViewCardContent())
               .background(TransparentBackground()) // <--- Here
                    .edgesIgnoringSafeArea(.all)

        }
    }
}



// Gerne noch in neue Model machen, bin frustriert 
struct TOCropViewWrapper: UIViewControllerRepresentable {
    // Bindings to share state between SwiftUi and UIkit components
    @Binding var selectedImage: UIImage?
    @Binding var isActive: Bool

    // creates and configures an instance of CropViewController
    func makeUIViewController(context: Context) -> TOCropViewController {
        let cropViewController = TOCropViewController(croppingStyle: .default, image: selectedImage ?? UIImage())
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
//updates the viewcontrroller when SwiftUI state Changes
    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) {}

    //Creates a coordinator to manage communication between Ui and UiKit view COntroller
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
// handels delgate methods of the CropViewController
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: TOCropViewWrapper

        //Initializes with a reference to the parent wrapper
        init(_ parent: TOCropViewWrapper) {
            self.parent = parent
        }

        //Delegeate method called when the imaeg has been cropped
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.selectedImage = image // updates the selected image with the cropped image
            parent.isActive = false // Schließt das Sheet
        }
    }
}

#Preview {
    CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true))
}
