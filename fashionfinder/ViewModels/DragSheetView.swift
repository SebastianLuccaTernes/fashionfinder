import UIKit
import SwiftUI


protocol CardContent {
    // Define any properties or methods your content needs to expose
    var view: AnyView { get }

}
class DraggableSheetViewController<Content: CardContent>: UIViewController {

    var sheetView: UIView!
    var sheetViewHeightConstraint: NSLayoutConstraint!
    private var content: Content

    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSheetView()
        addContent()
        
    }
    
    func setupUI() {
    }
    
    func setupSheetView() {
        sheetView = UIView()
        sheetView.backgroundColor = UIColor(named: "grey_F")
        //sheetView.layer.borderColor = UIColor.black.cgColor // Set the stroke color
        //sheetView.layer.borderWidth = 1.0 // Set the stroke width

        view.addSubview(sheetView)
        
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 16 // Define padding here within the method scope
        
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
            
        // Drag Indicator setup
            let dragIndicator = UIView()
            dragIndicator.backgroundColor = UIColor.systemGray3 // Choose a color that fits your design
            dragIndicator.layer.cornerRadius = 3 // Adjust for a rounded appearance

            sheetView.addSubview(dragIndicator)

            dragIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dragIndicator.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 8), // Position from the top of the sheet
                dragIndicator.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor), // Center horizontally
                dragIndicator.widthAnchor.constraint(equalToConstant: 40), // Width of the drag indicator
                dragIndicator.heightAnchor.constraint(equalToConstant: 6) // Height of the drag indicator
            
        ])
        
        sheetViewHeightConstraint = sheetView.heightAnchor.constraint(equalToConstant: 200)
        sheetViewHeightConstraint.isActive = true
        
        sheetView.layer.cornerRadius = 30
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Rounds only the top corners


        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan))
        sheetView.addGestureRecognizer(panGesture)
    }
    
    @objc  func handleSheetPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: sheetView)
        let newHeight = sheetViewHeightConstraint.constant - translation.y
        
        if newHeight > 100, newHeight < UIScreen.main.bounds.height * 0.8 {
            sheetViewHeightConstraint.constant = newHeight
            gesture.setTranslation(.zero, in: sheetView)
        }
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func addContent() {
        let hostingController = UIHostingController(rootView: content.view)
        addChild(hostingController)
        sheetView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        
        hostingController.view.backgroundColor = UIColor.clear


        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: sheetView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor)
        ])

        //sheetView.layer.borderWidth = 1
        //sheetView.layer.borderColor = UIColor.red.cgColor
        
        // Important for the right corner use.
        sheetView.clipsToBounds = true


        
    }
    
}

// Wrapper for your DraggableSheetViewController
struct CustomCardContent: CardContent {
    var view: AnyView {
        AnyView(
            
            VStack {
                
                Text("Product Listing")
            }
                .background(Color.clear)

        )
        
    }
    
}





struct DraggableSheetView<Content: CardContent>: UIViewControllerRepresentable {
    let content: Content

    func makeUIViewController(context: Context) -> some UIViewController {
        DraggableSheetViewController(content: content)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}


//Below is just QOL Preview for Testing purposes!


#Preview {
    DraggableSheetView(content: CustomCardContent())
}
