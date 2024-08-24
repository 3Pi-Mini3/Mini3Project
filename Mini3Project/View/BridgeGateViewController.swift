//
//  BridgeGateViewController.swift
//  Mini3Project
//
//  Created by Rania Pryanka Arazi on 21/08/24.
//

import SwiftUI


class BridgeGateViewController: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gate1")
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var descTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .black
        label.numberOfLines = 0

        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyEmphasized.title3
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
        label.text = "-"
        label.textColor = .black
        label.numberOfLines = 0

        
        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyRegular.subhead
        typographyAttributes[.paragraphStyle] = customParagraphStyle

        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: typographyAttributes
        )
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBrdigeGateView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateContent(imageName: String, titleText: String, subTitleText: String) {
        imageView.image = UIImage(named: imageName)
        
        descTitleLabel.text = titleText
        
        descSubLabel.text = subTitleText
    }
}

extension BridgeGateViewController {
    private func setupBrdigeGateView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 488),
            
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 75),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 44),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -44),
        ])
        
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 391),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
           ])
        
        contentView.addSubview(descTitleLabel)
        
        NSLayoutConstraint.activate([
            descTitleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            descTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            descTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            descTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        
        contentView.addSubview(descSubLabel)
        
        NSLayoutConstraint.activate([
            descSubLabel.heightAnchor.constraint(equalToConstant: 36),
            
            descSubLabel.topAnchor.constraint(equalTo: descTitleLabel.bottomAnchor, constant: 0),
            descSubLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            descSubLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
    }
}


//preview
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
//            let vc = BridgeGateViewController()
//            return vc
//        }
//    }
//}
