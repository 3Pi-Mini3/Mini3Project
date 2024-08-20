//
//  CardView.swift
//  Mini3Project
//
//  Created by Agfi on 19/08/24.
//

import UIKit

class CardView: UIView {
    
    // Card content label
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(content: String) {
        super.init(frame: .zero)
        setupCard(content: content)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCard(content: "")
    }
    
    private func setupCard(content: String) {
        // Set background color
        backgroundColor = UIColor.systemGray6
        
        // Set corner radius and border
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        // Set up the content label
        contentLabel.text = content
        addSubview(contentLabel)
        
        // Left-aligned constraints for the content label
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
