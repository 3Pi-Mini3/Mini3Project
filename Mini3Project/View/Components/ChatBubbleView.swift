//
//  ChatBubbleView.swift
//  Mini3Project
//
//  Created by Lucky on 22/08/24.
//

import UIKit

class ChatBubbleView: UIView {
    
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(isLeft: Bool, text: String) {
        super.init(frame: .zero)
        
        setupChatBubbleView(isLeft: isLeft, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ChatBubbleView {
    private func setupChatBubbleView(isLeft: Bool, text: String) {
        self.backgroundColor = isLeft ? UIColor(named: "CardBG")?.withAlphaComponent(0.12) : UIColor(named: "BTint100")
         self.layer.cornerRadius = 12
         self.layer.maskedCorners = isLeft ? [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
         self.translatesAutoresizingMaskIntoConstraints = false
         
         chatLabel.text = text
         chatLabel.textColor = isLeft ? UIColor(named: "Text") : .white
         
         let attributedText = NSAttributedString(
             string: chatLabel.text ?? "",
             attributes: TypographyRegular.body
         )
         chatLabel.attributedText = attributedText
         
         self.addSubview(chatLabel)
         
         NSLayoutConstraint.activate([
             chatLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
             chatLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
             chatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
             chatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
         ])
    }
}
