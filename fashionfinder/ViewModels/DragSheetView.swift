import UIKit
import SwiftUI

/* To-Do List -Luca  //
 1. Animations for Pangesture for example XXX
 2. Make Sheet fullscreen at the Bottom
 3. Remove second White BG Layer
 3.1. Related Layers:
 PresentationHostingController<Anyview>
         PresentationHostingController<Anyview>
 4. Make it Dark Mode Friendly

                        */


// Customizers - Settings
var def_maxHeight: Double = 0.9
var def_minHeight: Double = 0.3
var initialHeightFactor: Double = 0.9
var dismissal_velocity: CGFloat = 1000

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
        view.backgroundColor = UIColor.clear  // For the draggable sheet's root view

        setupUI()
        setupSheetView()  // Ensure this method initializes panGesture
        addContent()

        
    
    }


    
    func setupUI() {
        // To be added Later...
        view.backgroundColor = UIColor.clear  // Set the background color to clear


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
            sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

            
        ])
        //print("Gesture Recognizer added to dragIndicator")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan))
        sheetView.addGestureRecognizer(panGesture)
        panGesture.delegate = self  // Assigning the delegate here
    
        
        sheetViewHeightConstraint = sheetView.heightAnchor.constraint(equalToConstant: 200)
        sheetViewHeightConstraint.constant = UIScreen.main.bounds.height * initialHeightFactor
        sheetViewHeightConstraint.isActive = true
        sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
        sheetView.layer.cornerRadius = 30
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        // Drag Indicator setup
        let dragIndicator = UIView()
        dragIndicator.backgroundColor = UIColor.gray // Choose a color that fits your design
        dragIndicator.layer.cornerRadius = 3 // Adjust for a rounded appearance
        dragIndicator.isUserInteractionEnabled = true

        sheetView.addSubview(dragIndicator)
        //sheetView.bringSubviewToFront(dragIndicator)  // Make sure the dragIndicator is on top

        
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicator.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 8), // Position from the top of the sheet
            dragIndicator.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor), // Center horizontally
            dragIndicator.widthAnchor.constraint(equalToConstant: 50), // Width of the drag indicator
            dragIndicator.heightAnchor.constraint(equalToConstant: 8) // Height of the drag indicator
            
        ])
        
  



    }
    
    @objc func handleSheetPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        switch gesture.state {
        case .changed:
            // Calculate the new height based on the drag, but don't let it go below a minimum height
            var newHeight = sheetViewHeightConstraint.constant - translation.y
            newHeight = max(newHeight, def_minHeight)
            newHeight = min(newHeight, UIScreen.main.bounds.height * def_maxHeight)

            sheetViewHeightConstraint.constant = newHeight
            gesture.setTranslation(.zero, in: view)

        case .ended:
            // Use velocity and translation to decide what to do when the gesture ends
            if velocity.y > dismissal_velocity {  // Velocity threshold for dismissal
                self.dismiss(animated: true)
            } else if velocity.y < -dismissal_velocity {
                // Snap to full height if the swipe was upwards with significant velocity
                UIView.animate(withDuration: 0.3) {
                    self.sheetViewHeightConstraint.constant = UIScreen.main.bounds.height * def_maxHeight
                    self.view.layoutIfNeeded()
                }
            } else {
                // Optionally snap to nearest predefined height or allow it to stay at the current height
                // You can implement your logic here based on your requirements
            }

        default:
            break
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
           // Set up constraints for hostingController.view...
        

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: sheetView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor)
        ])
        hostingController.view.backgroundColor = UIColor.clear  // Ensure it's transparent


        //sheetView.layer.borderWidth = 1
        //sheetView.layer.borderColor = UIColor.red.cgColor
        
        // Important for the right corner use.
        sheetView.clipsToBounds = true


        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
    
}



// Structure to make UIKit Layers Transparent
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


// Wrapper for your DraggableSheetViewController
struct CustomCardContent: CardContent {
    var view: AnyView {
        AnyView(
            
            VStack {
                
                Text("Product Listing")
            }

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

#if DEBUG
#Preview {
    ZStack {
        DraggableSheetView(content: ListViewCardContent())
            .edgesIgnoringSafeArea(.all)

        
    }
    .background(Color.clear)  // Apply background color here
}
#endif
