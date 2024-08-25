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

        setupTabBar()

        let firstVC = SkillsViewController()
        let secondVC = ReflectionsViewController(viewModel: ReflectionsViewModel())

        let firstVCIcon = UIImage(systemName: "target")?.withRenderingMode(.alwaysOriginal)
        let secondVCIcon = UIImage(systemName: "book.pages.fill")?.withRenderingMode(.alwaysOriginal)

        firstVC.tabBarItem = UITabBarItem(title: "Skills", image: firstVCIcon, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Reflection", image: secondVCIcon, tag: 1)

        viewControllers = [firstVC, secondVC]

        setupMiddleButton()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
            self.shapeLayer.fillColor = UIColor(named: "TabBarBG")?.cgColor
        })
    }


    func setupTabBar() {
        shapeLayer.path = createCurvePath()
        shapeLayer.fillColor = UIColor(named: "TabBarBG")?.cgColor
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 5

        tabBar.layer.insertSublayer(shapeLayer, at: 0)

        let tabBarBorderPath = UIBezierPath(rect: CGRect(x: 0, y: tabBar.bounds.height - 2, width: tabBar.bounds.width, height: 2))
        tabBarBorderLayer.path = tabBarBorderPath.cgPath
        tabBarBorderLayer.lineWidth = 5
        tabBarBorderLayer.fillColor = UIColor.clear.cgColor
        tabBar.layer.addSublayer(tabBarBorderLayer)

        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = UIColor(named: "BTint100")
        tabBar.unselectedItemTintColor = UIColor(named: "TabBarUnselected")
    }

    func createCurvePath() -> CGPath {
        let height: CGFloat = 110

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
        middleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        middleButton.layer.cornerRadius = 40
        middleButton.backgroundColor = UIColor(named: "BTint100")
        
        let plusImage = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        middleButton.setImage(plusImage, for: .normal)
        middleButton.tintColor = .white

        view.addSubview(middleButton)

        let middleButtonBorderPath = UIBezierPath(ovalIn: middleButton.bounds.insetBy(dx: -2, dy: -2))
        middleButtonBorderLayer.path = middleButtonBorderPath.cgPath
//        middleButtonBorderLayer.strokeColor = UIColor.white.cgColor
//        middleButtonBorderLayer.lineWidth = 4
        middleButtonBorderLayer.fillColor = UIColor.clear.cgColor
        middleButton.layer.addSublayer(middleButtonBorderLayer)

        var buttonFrame = middleButton.frame
        buttonFrame.origin.y = view.bounds.height - buttonFrame.height - tabBar.bounds.height + 10
        buttonFrame.origin.x = view.bounds.width / 2 - buttonFrame.size.width / 2
        middleButton.frame = buttonFrame

        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
    }


    @objc func middleButtonTapped() {
        let vc = BridgeChatViewController()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Skills"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func dismissChatViewController() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shapeLayer.path = createCurvePath()
        tabBarBorderLayer.frame = tabBar.bounds
        middleButtonBorderLayer.frame = middleButton.bounds
    }
}
