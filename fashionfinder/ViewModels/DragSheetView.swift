import UIKit
import SwiftUI

/* To-Do List -Luca  //
 1. Animations for Pangesture for example XXX
 2. Make Sheet fullscreen at the Bottom
 3. Remove second White BG Layer

                        */


// Customizers - Settings
var def_maxHeight: Double = 0.8
var def_minHeight: Double = 0.3

// Settings End

protocol CardContent {
    // Define any properties or methods your content needs to expose
    var view: AnyView { get }

}
class DraggableSheetViewController<Content: CardContent>: UIViewController, UIGestureRecognizerDelegate {

    var sheetView: UIView!
    var sheetViewHeightConstraint: NSLayoutConstraint!
    var content: Content

    

    
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
        setupSheetView()  // Ensure this method initializes panGesture
        addContent()

        
    
    }


    
    func setupUI() {
        // To be added Later...
        view.backgroundColor = UIColor.clear  // Set the background color to clear
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)  // Semi-transparent black background

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
        //print("Gesture Recognizer added to dragIndicator")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan))
        sheetView.addGestureRecognizer(panGesture)
        panGesture.delegate = self  // Assigning the delegate here
    
        
        sheetViewHeightConstraint = sheetView.heightAnchor.constraint(equalToConstant: 200)
        sheetViewHeightConstraint.isActive = true
        
        sheetView.layer.cornerRadius = 30
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Drag Indicator setup
        let dragIndicator = UIView()
        dragIndicator.backgroundColor = UIColor.systemGray3 // Choose a color that fits your design
        dragIndicator.layer.cornerRadius = 3 // Adjust for a rounded appearance
        dragIndicator.isUserInteractionEnabled = true

        sheetView.addSubview(dragIndicator)
        
        
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicator.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 8), // Position from the top of the sheet
            dragIndicator.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor), // Center horizontally
            dragIndicator.widthAnchor.constraint(equalToConstant: 50), // Width of the drag indicator
            dragIndicator.heightAnchor.constraint(equalToConstant: 8) // Height of the drag indicator
            
        ])
        
  


      //  let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan))
      //  sheetView.addGestureRecognizer(panGesture)
    }
    
    @objc func handleSheetPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: sheetView)
        var newHeight = max(100, sheetViewHeightConstraint.constant - translation.y) // Prevents the sheet from going too low, adjust '100' as needed

        // Apply the minimum height constraint to prevent the sheet from going too low
        let minHeight: CGFloat = def_minHeight // Adjust this value as needed
        newHeight = max(minHeight, newHeight)
        
        // Apply the maximum height constraint to prevent the sheet from going too high
        let maxHeight: CGFloat = UIScreen.main.bounds.height * def_maxHeight // Adjust this value as needed
        newHeight = min(maxHeight, newHeight)
        
        // Apply a minimal animation for smoother height adjustment
        UIView.animate(withDuration: 0.05, delay: 0, options: [.curveEaseOut], animations: {
            self.sheetViewHeightConstraint.constant = newHeight
            self.view.layoutIfNeeded()
        }, completion: nil)

        gesture.setTranslation(.zero, in: sheetView)

        if gesture.state == .ended {
            // Animate gently to settle the sheet after the drag ends
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }


    func animateToEndPosition() {
        // Determine the nearest state. This is just an example; you might need more sophisticated logic.
        let expandedHeight = UIScreen.main.bounds.height * 0.8
        let collapsedHeight: CGFloat = 200
        let halfwayPoint = (expandedHeight + collapsedHeight) / 2
        var targetHeight = collapsedHeight

        if sheetViewHeightConstraint.constant > halfwayPoint {
            targetHeight = expandedHeight
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.sheetViewHeightConstraint.constant = targetHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
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


        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
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


#if DEBUG


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
#endif
