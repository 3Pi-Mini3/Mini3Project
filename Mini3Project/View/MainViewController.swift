//
//  ViewController.swift
//  Mini3Project
//
//  Created by Lucky on 14/08/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Hello, UIKit!"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        let navigateButton = UIButton(type: .system)
        navigateButton.setTitle("Go to Chat", for: .normal)
        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        navigateButton.addTarget(self, action: #selector(navigateToChat), for: .touchUpInside)
        view.addSubview(navigateButton)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            navigateButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func navigateToChat() {
        let chatVC = ChatViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
