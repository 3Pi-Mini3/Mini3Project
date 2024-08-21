//
//  DetailSkillViewController.swift
//  Mini3Project
//
//  Created by Agfi on 21/08/24.
//

import UIKit

class DetailSkillViewController: UIViewController {
    
    var skillCategory: String?
    var skills: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = skillCategory
        
        // Setup your UI here for the detail skill page
        let titleLabel = UILabel()
        titleLabel.text = skillCategory
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let skillsLabel = UILabel()
        skillsLabel.text = "Skills:"
        skillsLabel.font = UIFont.systemFont(ofSize: 20)
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let skillsStackView = UIStackView()
        skillsStackView.axis = .vertical
        skillsStackView.spacing = 8
        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for skill in skills {
            let skillLabel = UILabel()
            skillLabel.text = skill
            skillLabel.font = UIFont.systemFont(ofSize: 18)
            skillsStackView.addArrangedSubview(skillLabel)
        }
        
        view.addSubview(titleLabel)
        view.addSubview(skillsLabel)
        view.addSubview(skillsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            skillsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            skillsStackView.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 8),
            skillsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}
