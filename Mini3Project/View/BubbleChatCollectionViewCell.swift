//
//  BubbleChatCollectionViewCell.swift
//  Mini3Project
//
//  Created by Lucky on 21/08/24.
//

import UIKit

class BubbleChatCollectionViewCell: UICollectionViewCell {
    
    // Properties
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add bubbleView and messageLabel to the contentView
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuration method
    func configure(isLeft: Bool, text: String) {
        // Set bubbleView appearance
        bubbleView.backgroundColor = isLeft ? UIColor(named: "CardBG")?.withAlphaComponent(0.12) : UIColor(named: "BTint100")
        bubbleView.layer.maskedCorners = isLeft ? [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        // Set messageLabel text and color
        messageLabel.text = text
        messageLabel.textColor = isLeft ? UIColor(named: "Text") : UIColor(named: "ContrastText")
        let attributedText = NSAttributedString(
            string: messageLabel.text ?? "",
            attributes: TypographyRegular.caption1
        )
        messageLabel.attributedText = attributedText
        
        // Apply constraints
        NSLayoutConstraint.deactivate(bubbleView.constraints) // Reset constraints if needed

        let leadingConstraint = isLeft ? bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor) : bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 1.0), 
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
    }
}

