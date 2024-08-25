//
//  SkillsContentViewController.swift
//  Mini3Project
//
//  Created by Agfi on 20/08/24.
//

import UIKit

class SkillsContentViewController: UIViewController {
    
    private let hStackSpacing: CGFloat = 16
    private let cardHeight: CGFloat = 60
    
    private var softSkill: [Skill] = []
    private var hardSkill: [Skill] = []
    private let skillsViewModel = SkillsViewModel()
    
    var selectedRole: String = "coding" {
        didSet {
            updateContent(forRole: selectedRole, softSkill: skillsViewModel.fetchSkills(forRole: "softskill", skillType: "softskill"), hardSkill: skillsViewModel.fetchSkills(forRole: selectedRole, skillType: "hardskill"))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateContent(forRole: selectedRole, softSkill: skillsViewModel.fetchSkills(forRole: "softskill", skillType: "softskill"), hardSkill: skillsViewModel.fetchSkills(forRole: selectedRole, skillType: "hardskill"))
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func updateContent(forRole role: String, softSkill: [Skill], hardSkill: [Skill]) {
        self.softSkill = softSkill
        self.hardSkill = hardSkill
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        addTitleLabel(to: mainStack)
        addSpacing(to: mainStack, height: 16)
        
        addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: softSkill, skills2: hardSkill)
    }
    
    private func addTitleLabel(to stack: UIStackView) {
        let titleLabel = UILabel()
        titleLabel.text = "Latest Updated Skills"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
    }
    
    private func addContentStack(to stack: UIStackView, title1: String, title2: String, skills1: [Skill], skills2: [Skill]) {
        addHStack(to: stack, title: title1, skills: skills1, tag: 1)
        addSpacing(to: stack, height: 16)
        addHStack(to: stack, title: title2, skills: skills2, tag: 2)
    }
    
    private func addHStack(to stack: UIStackView, title: String, skills: [Skill], tag: Int) {
        let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.alignment = .fill
        hStack.spacing = 8
        hStack.translatesAutoresizingMaskIntoConstraints = false

        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        headerStack.spacing = hStackSpacing
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let showMoreButton = UIButton(type: .system)
        showMoreButton.setTitle("Show More", for: .normal)
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false

        // Add target action for the Show More button
        showMoreButton.addTarget(self, action: #selector(showMoreButtonTapped(_:)), for: .touchUpInside)
        showMoreButton.tag = tag  // Tag used to differentiate between soft skills and hard skills

        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(showMoreButton)

        hStack.addArrangedSubview(headerStack)
        
        if skills.isEmpty {
            let placeholderStack = UIStackView()
            placeholderStack.axis = .vertical
            placeholderStack.alignment = .center
            placeholderStack.spacing = 8
            placeholderStack.translatesAutoresizingMaskIntoConstraints = false

            let placeholderImageView = UIImageView(image: UIImage(named: "MascotSad"))
            placeholderImageView.contentMode = .scaleAspectFit
            placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                placeholderImageView.heightAnchor.constraint(equalToConstant: 114)
            ])

            let placeholderLabel = UILabel()
            placeholderLabel.text = "You don't have any skills yet"
            placeholderLabel.font = UIFont.systemFont(ofSize: 16)
            placeholderLabel.textColor = .gray
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

            placeholderStack.addArrangedSubview(placeholderImageView)
            placeholderStack.addArrangedSubview(placeholderLabel)

            hStack.addArrangedSubview(placeholderStack)
        } else {
            let latestSkills = skills.sorted { $0.createdAt > $1.createdAt }.prefix(3)

            for skill in latestSkills {
                let skillView = createSkillView(skillName: skill.name, borderColorName: "BTint200")
                hStack.addArrangedSubview(skillView)
            }
        }

        stack.addArrangedSubview(hStack)
    }
    
    private func addSpacing(to stack: UIStackView, height: CGFloat) {
        let spacingView = UIView()
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.heightAnchor.constraint(equalToConstant: height).isActive = true
        stack.addArrangedSubview(spacingView)
    }
    
    @objc private func showMoreButtonTapped(_ sender: UIButton) {
        let skillCategory: String

        switch sender.tag {
        case 1:
            skillCategory = "softskill"
        case 2:
            skillCategory = "hardskill"
        default:
            return
        }
        
        let detailSkillVC = DetailSkillViewController()
        detailSkillVC.skillCategory = skillCategory
        detailSkillVC.selectedRole = selectedRole  // Pass the selected role
        navigationController?.pushViewController(detailSkillVC, animated: true)
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
        ])
        
        return skillView
    }
}
