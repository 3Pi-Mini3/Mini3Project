//
//  CardViewController.swift
//  Mini3Project
//
//  Created by Agfi on 19/08/24.
//

import UIKit

class CardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view background color
        view.backgroundColor = .white
        
        // Create and configure the card view
        let cardView = CardView(content: "This is a card with left-aligned content, a border, and a background color.")
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the card to the view
        view.addSubview(cardView)
        
        // Set constraints for the card view (left alignment, some padding)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}
