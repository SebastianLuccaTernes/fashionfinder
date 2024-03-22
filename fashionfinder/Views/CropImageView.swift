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
    @State private var isStartViewActive = false
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
                        isStartViewActive = true
                    }) { Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .fullScreenCover(isPresented: $isStartViewActive) {
                                StartView()
                            }
                    }
                    Text("FINDr.".uppercased())
                        .font(.custom("BaseNeueTrial-Regular", size: 36))
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
                    Image("Dog") // Picture Example
                    //Error handling @Sebastian?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 1000 * 9 / 16)
                        .border(Color.black, width: 1)
                        .padding()
                        .clipShape(Rectangle())
                        .onTapGesture {
                            self.isCropViewActive = true //activates sheet
                        }
                            
                        }
                    Spacer()
                    
                    Spacer() // Füllt den verfügbaren Raum und drückt den Button nach unten
                    
                    CustomButton(title: "Find It", ButtonWidth: 150, ButtonHeight: 50, backgroundColor: Color.black) {
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
