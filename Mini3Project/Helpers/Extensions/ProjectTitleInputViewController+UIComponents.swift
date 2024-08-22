//
//  ProjectTitleInputViewController+UIComponents.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit

extension ProjectTitleInputViewController {
    func createTitleView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func createTextFieldView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CardBG")?.withAlphaComponent(0.12)
        view.layer.cornerRadius = 10
        
        view.layer.borderColor = UIColor(named: "LineStroke")?.cgColor
        view.layer.borderWidth = 1.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }    
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        
        let placeholderText = "Add your project name"
        let attributedText = NSAttributedString(
            string: placeholderText,
            attributes: TypographyRegular.body
        )
        textField.attributedPlaceholder = attributedText
        
        textField.textColor = UIColor(named: "Text")
        
        textField.tintColor = UIColor(named: "Bluemarine")
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Project Name"
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .left
        
        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: TypographyEmphasized.largeTitle
        )
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false 
        
        return label
    }
    
    func createNextButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "BTint200")
        button.layer.cornerRadius = 10
        
        let titleColor = UIColor(named: "BTint300")!
        
        let attributedText = NSAttributedString(
            string: "Next",
            attributes: TypographyEmphasized.body.merging([
                .foregroundColor: titleColor
            ]) { (current, _) in current }
        )
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = false
        
        return button
    }
    
    func createMascotImageView() -> MascotImageView {
        let view = MascotImageView(imageName: "projectNameMascot")
        view.configure(contentMode: .scaleAspectFill, cornerRadius: 0)
        return view
    }
}
