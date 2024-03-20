//
//  cropImageView.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 11.03.24.
//

import SwiftUI
import CropViewController

struct CropImageView: View {
    @Binding var selectedImage: UIImage?
    @Binding var showCropImageView: Bool
    @State private var isCropViewActive = false
   
    
    var body: some View {
        ZStack {// Hintergrundbild oder Farbe
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack { // Title und back taste
                    Button(action: {
                        // Action to dismiss the fullScreenCover
                        showCropImageView = false
                    }) { Image(systemName: "chevron.left")
                            .foregroundColor(.black
                            )
                        
                    }
                    Text("FINDr.".uppercased())
                        .padding()
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                    
                    
                }
                
                if let image = selectedImage { // if an image is picket it is shown here
                    GeometryReader { geometry in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)
                            .border(Color.black, width: 1)
                            .padding()
                            .clipShape(Rectangle())
                            .onTapGesture {
                                self.isCropViewActive = true //activates sheet 
                            }
                    }
                } else {
                    let image = Image("Dog") // Picture Example
                       //Error handling @Sebastian?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200 * 9 / 16)
                        .border(Color.black, width: 1)
                        .padding()
                        .clipShape(Rectangle())
                       

                }
                Spacer()
                
                Spacer() // Füllt den verfügbaren Raum und drückt den Button nach unten
                
                Button(action: {
                    print("Button gedrückt")
                }) {
                    Text("Find It")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.lavendel) // Buttonfarbe
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $isCropViewActive) {
                CropViewWrapper(selectedImage: $selectedImage, isActive: $isCropViewActive)
            }
        }
    }
}

// Gerne noch in neue Model machen, bin frustriert 
struct CropViewWrapper: UIViewControllerRepresentable {
    // Bindings to share state between SwiftUi and UIkit components
    @Binding var selectedImage: UIImage?
    @Binding var isActive: Bool

    // creates and configures an instance of CropViewController
    func makeUIViewController(context: Context) -> CropViewController {
        let cropViewController = CropViewController(croppingStyle: .default, image: selectedImage ?? UIImage())
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
//updates the viewcontrroller when SwiftUI state Changes
    func updateUIViewController(_ uiViewController: CropViewController, context: Context) {}

    //Creates a coordinator to manage communication between Ui and UiKit view COntroller
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
// handels delgate methods of the CropViewController
    class Coordinator: NSObject, CropViewControllerDelegate {
        var parent: CropViewWrapper

        //Initializes with a reference to the parent wrapper
        init(_ parent: CropViewWrapper) {
            self.parent = parent
        }

        //Delegeate method called when the imaeg has been cropped
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            parent.selectedImage = image // updates the selected image with the cropped image
            parent.isActive = false // Schließt das Sheet
        }
    }
}

#Preview {
    CropImageView(selectedImage: .constant(nil), showCropImageView: .constant(true))
}
