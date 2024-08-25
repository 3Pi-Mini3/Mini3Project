//
//  OnboardingViewController.swift
//  Mini3Project
//
//  Created by Lucky on 25/08/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var labelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BTint100")
        view.layer.cornerRadius = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Let’s start your reflection here to know your strengths!"
        label.textColor = UIColor(named: "BTint300")
        label.numberOfLines = 0

        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center
        
        var typographyAttributes = TypographyRegular.headline
        typographyAttributes[.paragraphStyle] = customParagraphStyle

        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: typographyAttributes
        )
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 40
        button.backgroundColor = UIColor(named: "BTint100")
        
        let plusImage = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        button.setImage(plusImage, for: .normal)
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var mascotImageView: MascotImageView = {
        let view = MascotImageView(imageName: "HalloMascot")
        view.configure(contentMode: .scaleAspectFill, cornerRadius: 0)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "OverlayAlert")
        
        setupOnboardingView()
    }

}

private extension OnboardingViewController {
    @objc private func plusButtonTapped() {
        let vc = BridgeChatViewController()
        
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        
        let customBackButton = UIButton(type: .system)
        customBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        customBackButton.setTitle(" Skills", for: .normal)
        customBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        customBackButton.addTarget(self, action: #selector(dismissOnboardingView), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: customBackButton)
        vc.navigationItem.leftBarButtonItem = backButtonItem

        present(navController, animated: true, completion: nil)
    }
    
    @objc func dismissOnboardingView() {
        dismiss(animated: true, completion: nil)
    }
}

private extension OnboardingViewController {
    private func setupOnboardingView() {
        
        self.view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 341),
            
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -39),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        contentView.addSubview(mascotImageView)
        
        NSLayoutConstraint.activate([
            mascotImageView.heightAnchor.constraint(equalToConstant: 234),
            
            mascotImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mascotImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        contentView.addSubview(centerView)
        
        NSLayoutConstraint.activate([
            centerView.heightAnchor.constraint(equalToConstant: 159),
            
            centerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            centerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 69),
            centerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
        ])
        
        centerView.addSubview(labelView)
        
        NSLayoutConstraint.activate([
            labelView.heightAnchor.constraint(equalToConstant: 68),
            
            labelView.topAnchor.constraint(equalTo: centerView.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
        ])
        
        labelView.addSubview(promptLabel)
        
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 12),
            promptLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -12),
            promptLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 12),
            promptLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -12),
        ])
        
        centerView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 81),
            plusButton.heightAnchor.constraint(equalToConstant: 80),
            
            plusButton.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 11),
            plusButton.centerXAnchor.constraint(equalTo: centerView.centerXAnchor)
        ])
    }
}
