//
//  BridgeChatViewController.swift
//  Mini3Project
//
//  Created by Jonathan Andrew Yoel on 20/08/24.
//

import UIKit

class BridgeChatViewController: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private lazy var rectangleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "4stages")
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var descTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You will go through 4 stages to recognize your strengths!"
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
    
    
    private lazy var descSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's make sure to do it correctly!"
        label.textColor = .black
        label.numberOfLines = 0

        
        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyRegular.caption1
        typographyAttributes[.paragraphStyle] = customParagraphStyle

        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: typographyAttributes
        )
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var durationView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "duration")
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    private lazy var descTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10 min"
        label.textColor = .black
        label.numberOfLines = 0

        
        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyRegular.caption2
        typographyAttributes[.paragraphStyle] = customParagraphStyle

        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: typographyAttributes
        )
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private lazy var startButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(named: "BTint100")
            button.layer.cornerRadius = 10
            
            let titleColor = UIColor(named: "BGLight")
            
            let attributedText = NSAttributedString(
                string: "Start exploration 􀄫",
                attributes: TypographyEmphasized.body.merging([
                    .foregroundColor: titleColor!
                ]) { (current, _) in current }
            )
            button.setAttributedTitle(attributedText, for: .normal)
            
            button.addTarget(self, action: #selector(startExplorationButtonTapped), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBrdigeChatView()
    }
    
    @objc func startExplorationButtonTapped() {
        let alert = UIAlertController(title: "Middle Button", message: "Middle button tapped!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension BridgeChatViewController {
    private func setupBrdigeChatView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(contentView)
//        contentView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 562),
            
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 54),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70),
        ])
        
//        
//        contentView.addSubview(rectangleView)
//        NSLayoutConstraint.activate([
//            rectangleView.heightAnchor.constraint(equalToConstant: 391),
//            
//            rectangleView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            rectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
//            rectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
//        ])
        
        contentView.addSubview(imageView)
//        imageView.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 282),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
           ])
        
        
        
        
        contentView.addSubview(descTitleLabel)
//        descTitleLabel.backgroundColor = .cyan
        NSLayoutConstraint.activate([
            descTitleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            descTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            descTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        
        contentView.addSubview(descSubLabel)
//        descSubLabel.backgroundColor = .blue
        NSLayoutConstraint.activate([
            descSubLabel.heightAnchor.constraint(equalToConstant: 16),
            
            descSubLabel.topAnchor.constraint(equalTo: descTitleLabel.bottomAnchor, constant: 8),
            descSubLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            descSubLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        
        
        contentView.addSubview(durationView)
//        durationView.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
               durationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               durationView.topAnchor.constraint(equalTo: descSubLabel.bottomAnchor, constant: 16),
               durationView.widthAnchor.constraint(equalToConstant: 50),
               durationView.heightAnchor.constraint(equalToConstant: 50)
           ])
        
        contentView.addSubview(descTimeLabel)
//        descTimeLabel.backgroundColor = .blue
        NSLayoutConstraint.activate([
            descTimeLabel.heightAnchor.constraint(equalToConstant: 16),
            
            descTimeLabel.topAnchor.constraint(equalTo: durationView.bottomAnchor, constant: 8),
            descTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            descTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        
        contentView.addSubview(startButton)
//        startButton.backgroundColor = .blue
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 46),
            
            startButton.topAnchor.constraint(equalTo: descTimeLabel.bottomAnchor, constant: 164),
            startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
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
//            let vc = BridgeChatViewController()
//            return vc
//        }
//    }
//}
