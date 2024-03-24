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

struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct SubView: View {
    @Binding var showing: Bool
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            Text("Hello World")
            
            Button {
                showing = false
            } label: {
                Text("Close")
            }
        }
        .frame(width: width, height: height)
        .background(.teal)
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
