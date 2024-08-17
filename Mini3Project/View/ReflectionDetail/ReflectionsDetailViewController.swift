//
//  ReflectionDetailViewController.swift
//  Mini3Project
//
//  Created by Christopher Nathanael Tessy on 15/08/24.
//

import UIKit

class ReflectionDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the view
        view.backgroundColor = .white

        // Add a label
        let label = UILabel()
        label.text = "Reflection Detail"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // Center the label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
