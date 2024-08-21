//
//  DetailSkillViewController.swift
//  Mini3Project
//
//  Created by Agfi on 21/08/24.
//

import UIKit

class DetailSkillViewController: UIViewController {
    var skills: [Skill]?
    var skillCategory: String?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let skillsContainer: UIStackView = UIStackView()
    private let skillsTitleLabel: UILabel = UILabel()
    private let skillsList: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSkillsSection()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "\(skillCategory ?? "") Skills"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSkillsSection() {
        skillsContainer.axis = .vertical
        skillsContainer.spacing = 8
        skillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        skillsTitleLabel.attributedText = NSAttributedString(
            string: "\(skillCategory ?? "") Skills",
            attributes: TypographyRegular.headline
        )
        skillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        skillsList.axis = .vertical
        skillsList.spacing = 8
        skillsList.translatesAutoresizingMaskIntoConstraints = false
        
        if let skills = skills {
            let filteredSkills = skills
                .filter { $0.type == skillCategory?.lowercased() }
                .map { $0.name }
            
            for skill in filteredSkills {
                let skillView = createSkillView(skillName: skill, borderColorName: "BTint200")
                skillsList.addArrangedSubview(skillView)
            }
        }
        
        skillsContainer.addArrangedSubview(skillsTitleLabel)
        skillsContainer.addArrangedSubview(skillsList)
        contentView.addSubview(skillsContainer)
        
        NSLayoutConstraint.activate([
            skillsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            skillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            skillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            skillsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func createSkillView(skillName: String, borderColorName: String) -> UIView {
        let skillView = UIView()
        if let borderColor = UIColor(named: borderColorName)?.cgColor {
            skillView.layer.borderColor = borderColor
        }
        skillView.layer.borderWidth = 1
        skillView.backgroundColor = UIColor(named: borderColorName)?.withAlphaComponent(0.2)
        skillView.layer.cornerRadius = 8
        skillView.translatesAutoresizingMaskIntoConstraints = false
        
        let skillLabel = UILabel()
        skillLabel.text = skillName
        skillLabel.font = UIFont.systemFont(ofSize: 16)
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "checkmark.seal.fill")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: borderColorName)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        skillView.addSubview(iconImageView)
        skillView.addSubview(skillLabel)
        
        NSLayoutConstraint.activate([
            skillView.heightAnchor.constraint(equalToConstant: 52),
            
            iconImageView.centerYAnchor.constraint(equalTo: skillView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: skillView.leadingAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            skillLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            skillLabel.trailingAnchor.constraint(equalTo: skillView.trailingAnchor, constant: -12)
        ])
        
        return skillView
    }
}
