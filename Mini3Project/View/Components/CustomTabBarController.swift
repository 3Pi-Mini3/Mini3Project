//
//  CustomTabBarController.swift
//  Mini3Project
//
//  Created by Agfi on 17/08/24.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let middleButton = UIButton()
    let shapeLayer = CAShapeLayer()
    let tabBarBorderLayer = CAShapeLayer()
    let middleButtonBorderLayer = CAShapeLayer()

    override func viewDidLoad() {
            super.viewDidLoad()

            // Set up the tab bar appearance with a deeper curve and transparency
            setupTabBar()

            // Set up the view controllers for the tabs
            let firstVC = MainViewController()
            let secondVC = ChatViewController()

            // Create SF Symbols for tab bar icons
            let firstVCIcon = UIImage(systemName: "target")?.withRenderingMode(.alwaysOriginal) // Example SF Symbol
            let secondVCIcon = UIImage(systemName: "book.pages.fill")?.withRenderingMode(.alwaysOriginal) // Example SF Symbol

            // Customize the tab bar items
            firstVC.tabBarItem = UITabBarItem(title: "Skills", image: firstVCIcon, tag: 0)
            secondVC.tabBarItem = UITabBarItem(title: "Reflection", image: secondVCIcon, tag: 1)

            viewControllers = [firstVC, secondVC]

            // Set up the middle button
            setupMiddleButton()
        }


    func setupTabBar() {
        // Create a custom tab bar curve with transparency
        shapeLayer.path = createCurvePath() // Set the path for the tab bar's curve
        shapeLayer.fillColor = UIColor.white.cgColor // Set the curve color to white
        shapeLayer.backgroundColor = UIColor.clear.cgColor // Transparent center section
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 5

        // Add the shape layer to the tab bar
        tabBar.layer.insertSublayer(shapeLayer, at: 0)

        // Create and add the tab bar border layer
        let tabBarBorderPath = UIBezierPath(rect: CGRect(x: 0, y: tabBar.bounds.height - 2, width: tabBar.bounds.width, height: 2))
        tabBarBorderLayer.path = tabBarBorderPath.cgPath
        tabBarBorderLayer.lineWidth = 5
        tabBarBorderLayer.fillColor = UIColor.clear.cgColor
        tabBar.layer.addSublayer(tabBarBorderLayer)

        // Ensure the tab bar isn't translucent
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.white // Set tab bar background to white
        tabBar.tintColor = UIColor(named: "BTint100")
        tabBar.unselectedItemTintColor = .gray
    }

    func createCurvePath() -> CGPath {
        let height: CGFloat = 110 // Adjust the depth of the curve to make it deeper

        let path = UIBezierPath()
        let width = tabBar.bounds.width
        let centerWidth = width / 2

        // Start at the left corner of the tab bar
        path.move(to: CGPoint(x: 0, y: 0))

        // Line to the start of the curve
        path.addLine(to: CGPoint(x: centerWidth - 60, y: 0))

        // Create the deeper curve (arc) in the center
        path.addQuadCurve(to: CGPoint(x: centerWidth + 60, y: 0), controlPoint: CGPoint(x: centerWidth, y: height))

        // Line to the end of the tab bar
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: tabBar.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        path.close()

        return path.cgPath
    }

    func setupMiddleButton() {
        // Create a circular button with width and height of 80
        middleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        middleButton.layer.cornerRadius = 40 // Half of the width/height to make it circular
        middleButton.backgroundColor = UIColor(named: "Bluemarine")
        
        // Set a custom image or scale the existing image
        let plusImage = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .black))
        middleButton.setImage(plusImage, for: .normal)
        middleButton.tintColor = UIColor(named: "Caution")

        // Add the middle button to the view
        view.addSubview(middleButton)

        // Create and add the middle button border layer with padding
        let middleButtonBorderPath = UIBezierPath(ovalIn: middleButton.bounds.insetBy(dx: -2, dy: -2))
        middleButtonBorderLayer.path = middleButtonBorderPath.cgPath
        middleButtonBorderLayer.strokeColor = UIColor.white.cgColor // White border color
        middleButtonBorderLayer.lineWidth = 4 // Width of the border
        middleButtonBorderLayer.fillColor = UIColor.clear.cgColor
        middleButton.layer.addSublayer(middleButtonBorderLayer)

        // Position the button to "hang" over the curve
        var buttonFrame = middleButton.frame
        buttonFrame.origin.y = view.bounds.height - buttonFrame.height - tabBar.bounds.height + 10
        buttonFrame.origin.x = view.bounds.width / 2 - buttonFrame.size.width / 2
        middleButton.frame = buttonFrame

        // Add action for button tap
        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
    }


    @objc func middleButtonTapped() {
        // Handle the middle button tap
        let alert = UIAlertController(title: "Middle Button", message: "Middle button tapped!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shapeLayer.path = createCurvePath() // Update the curve path when the layout changes
        tabBarBorderLayer.frame = tabBar.bounds // Update the tab bar border layer frame
        middleButtonBorderLayer.frame = middleButton.bounds // Update the middle button border layer frame
    }
}
