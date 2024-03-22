//
//  SliderView.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 22.03.24.
//

import Foundation
import SwiftUI

struct SliderView<Content: View>: UIViewControllerRepresentable {
    var content: Content
    @Binding var isActive: Bool
    @State private var finalHeight: CGFloat = 0

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(hostView.view)
        NSLayoutConstraint.activate([
            hostView.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            hostView.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])

        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePanGesture))
        viewController.view.addGestureRecognizer(panGesture)

        return viewController
    }


    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: SliderView
        let thresholdPostions: [CGFloat]

        init(_ parent: SliderView) {
            self.parent = parent
            self.thresholdPostions = [UIScreen.main.bounds.height / 4, UIScreen.main.bounds.height / 2, UIScreen.main.bounds.height * 3 / 4]
        }

        @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: gesture.view)
            let _velocity = gesture.velocity(in: gesture.view)

            switch gesture.state {
            case .changed:
                if let view = gesture.view {
                    let newY = view.frame.origin.y + translation.y
                    let maxY = UIScreen.main.bounds.height - view.frame.height
                    let minY = UIScreen.main.bounds.origin.y
                    let y = min(max(newY, minY), maxY)
                    view.frame.origin.y = y
                    gesture.setTranslation(.zero, in: view)
                }
            case .ended:
                if let view = gesture.view {
                    let finalY = thresholdPostions.min(by: { abs($0 - view.frame.origin.y) < abs($1 - view.frame.origin.y) }) ?? UIScreen.main.bounds.origin.y
                    UIView.animate(withDuration: 0.3, animations: {
                        view.frame.origin.y = finalY
                    }, completion: { _ in
                        if finalY == UIScreen.main.bounds.origin.y {
                            self.parent.isActive = false
                        } else {
                            // Update the finalHeight state variable
                            self.parent.finalHeight = view.frame.height
                        }
                    })
                }
            default:
                break
            }
        }



    }
}
