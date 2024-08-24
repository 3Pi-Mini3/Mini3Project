//
//  ReflectionChatView+UIComponents.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit

extension ReflectionChatViewController {
    
    func createTopView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createChatScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    func createChatView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createBottomView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CardBG")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    func createTextView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = UIColor(named: "AlertBG")
        
        textView.layer.cornerRadius = 20
        textView.layer.masksToBounds = true
        
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 12, bottom: 15, right: 12)
        
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        
        let placeholderText = " "
        let attributedText = NSAttributedString(
            string: placeholderText,
            attributes: TypographyRegular.body
        )
        textView.attributedText = attributedText
        
        textView.textColor = UIColor(named: "Text")
        textView.tintColor = UIColor(named: "Bluemarine")
        
        textView.delegate = self
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
    
    func createSendButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "Bluemarine")
        button.layer.cornerRadius = 16
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold, scale: .medium)
        let sendButton = UIImage(systemName: "paperplane.fill", withConfiguration: symbolConfiguration)
        
        button.setImage(sendButton, for: .normal)
        button.tintColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createNextButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "BTint100")
        button.layer.cornerRadius = 10
        
        let titleColor = UIColor(named: "ContrastText")!
        
        let attributedText = NSAttributedString(
            string: "Entry new gate",
            attributes: TypographyEmphasized.body.merging([
                .foregroundColor: titleColor
            ]) { (current, _) in current }
        )
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowColor = UIColor(named: "LineStroke")?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: -4)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        
        return button
    }
    
    func createBackButton() -> UIButton {
        let button = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold, scale: .medium)
        let backImage = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        
        button.setImage(backImage, for: .normal)
        button.tintColor = UIColor(named: "BTint200")
        
        button.isEnabled = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createMascotImageView() -> MascotImageView {
        let view = MascotImageView(imageName: "ReflectionsInput")
        view.configure(contentMode: .scaleAspectFill, cornerRadius: 0)
        return view
    }
    
    func createProgressBarView() -> ProgressBarView {
        return ProgressBarView()
    }
    
    func createConfirmationBarView() -> ConfirmationView {
        return ConfirmationView()
    }
}
