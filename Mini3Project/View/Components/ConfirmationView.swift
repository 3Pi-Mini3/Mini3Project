//
//  ConfirmationView.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit

class ConfirmationView: UIView {
    
    lazy var mascotImageView: MascotImageView = {
        let view = MascotImageView(imageName: "confirmationMascot")
        view.configure(contentMode: .scaleAspectFill, cornerRadius: 0)
        return view
    }()
    
    private lazy var confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't go yet! Your progress will be lost if you exit now"
        label.textColor = UIColor(named: "Text")
        label.numberOfLines = 0
        
        // Create a custom paragraph style to ensure proper alignment
        let customParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.alignment = .center

        // Merge custom paragraph style with existing typography
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
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "BTint100")
        button.layer.cornerRadius = 10
        
        let titleColor = UIColor.white
        
        let attributedText = NSAttributedString(
            string: "Continue",
            attributes: TypographyEmphasized.body.merging([
                .foregroundColor: titleColor
            ]) { (current, _) in current }
        )
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowColor = UIColor(named: "LineStroke")?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: -4)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        
        let titleColor = UIColor(named: "Error")!
        
        let attributedText = NSAttributedString(
            string: "Exit",
            attributes: TypographyEmphasized.body.merging([
                .foregroundColor: titleColor
            ]) { (current, _) in current }
        )
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var onContinue: (() -> Void)?
    var onExit: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConfirmationView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConfirmationView {
    
    private func setupConfirmationView() {
        self.backgroundColor = UIColor(named: "AlertBG")
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 100
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mascotImageView)
        
        NSLayoutConstraint.activate([
            mascotImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            mascotImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 91),
            mascotImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -91),
        ])
        
        self.addSubview(confirmationLabel)
        
        NSLayoutConstraint.activate([
            confirmationLabel.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor, constant: 23),
            confirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            confirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        self.addSubview(confirmationLabel)
        
        NSLayoutConstraint.activate([
            confirmationLabel.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor, constant: 23),
            confirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            confirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        self.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 46),
            
            continueButton.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 23),
            continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        self.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 70),
            exitButton.heightAnchor.constraint(equalToConstant: 22),
            
            exitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            exitButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func continueTapped() {
        onContinue?()
    }
    
    @objc private func exitTapped() {
        onExit?()
    }
}
