//
//  BridgeNextViewController.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit

class BridgeNextViewController: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Wow you’re so amazing!!! Let’s see your achieved skills"
        label.textColor = .black
        label.numberOfLines = 0

        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyEmphasized.body
        typographyAttributes[.paragraphStyle] = customParagraphStyle

        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: typographyAttributes
        )
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
    
        
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "BTint100")
        button.layer.cornerRadius = 10
        
        let titleColor = UIColor(named: "ContrastText")!
        
        let attributedText = NSAttributedString(
            string: "Back to skills page",
            attributes: TypographyEmphasized.body.merging([
                .foregroundColor: titleColor
            ]) { (current, _) in current }
        )
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var mascotImageView: MascotImageView = {
        let view = MascotImageView(imageName: "NextMascot")
        view.configure(contentMode: .scaleAspectFill, cornerRadius: 0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBridgeView()
    }
}

private extension BridgeNextViewController {
    @objc func nextButtonTapped() {
//        let vc = ProjectTitleInputViewController()
//        
//        let navController = UINavigationController(rootViewController: vc)
//        navController.modalPresentationStyle = .fullScreen
//
//        present(navController, animated: true, completion: nil)
    }
}

private extension BridgeNextViewController {
    
    private func setupBridgeView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 494),
            
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 81),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 41),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -42)
        ])
        
        contentView.addSubview(mascotImageView)
        
        NSLayoutConstraint.activate([
            mascotImageView.heightAnchor.constraint(equalToConstant: 430),
            
            mascotImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mascotImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mascotImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        contentView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        self.view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 46),
            
            nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        
    }
}

// PREVIEW
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//        //
//    }
//    
//    let viewController: ViewController
//
//    init(_ builder: @escaping () -> ViewController) {
//        viewController = builder()
//    }
//
//    // MARK: - UIViewControllerRepresentable
//    func makeUIViewController(context: Context) -> ViewController {
//        viewController
//    }
//}
//#endif
//
//struct BestInClassPreviews_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            // Return whatever controller you want to preview
//            let vc = BridgeNextViewController() 
//            return vc
//        }
//    }
//}
