//
//  DetailSkillViewController.swift
//  Mini3Project
//
//  Created by Agfi on 21/08/24.
//

import UIKit

class DetailSkillViewController: UIViewController {
    var skillCategory: String?
    var selectedRole: String?

    private let skillsViewModel = SkillsViewModel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let skillsContainer: UIStackView = UIStackView()
    private let skillsTitleLabel: UILabel = UILabel()
    private let skillsList: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScrollView()
        setupSkillsSection()
        loadSkills()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "\(skillCategory?.capitalized ?? "")"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupSkillsSection() {
        contentView.addSubview(skillsContainer)
        
        skillsContainer.axis = .vertical
        skillsContainer.spacing = 8
        skillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        skillsList.axis = .vertical
        skillsList.spacing = 8
        skillsList.translatesAutoresizingMaskIntoConstraints = false
        
        skillsContainer.addArrangedSubview(skillsTitleLabel)
        skillsContainer.addArrangedSubview(skillsList)
        
        NSLayoutConstraint.activate([
            skillsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            skillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            skillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            skillsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func loadSkills() {
        guard let category = skillCategory else { return }
        guard let role = selectedRole else { return }
        
        var filteredSkills: [Skill]
        
        if category.lowercased() == "softskill" {
            filteredSkills = skillsViewModel.fetchSkills(forRole: "softskill").filter { $0.type == "softskill" }
        } else {
            filteredSkills = skillsViewModel.fetchSkills(forRole: role).filter { $0.type == "hardskill" }
        }
        
        for skill in filteredSkills {
            let skillView = createSkillView(skillName: skill.name, borderColorName: "BTint200")
            skillsList.addArrangedSubview(skillView)
        }
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
