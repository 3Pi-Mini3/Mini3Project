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
    
    // Scroll View
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
        view.backgroundColor = .white
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
    
    func updateContent(forSegment segment: Int) {
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
        
        switch segment {
        case 0:
            addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: ["Communication", "Critical Thinking", "Public Speaking"], skills2: ["SwiftUI", "UIKit", "MVVM"])
        case 1:
            addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: ["Creativity", "User Research", "Prototyping"], skills2: ["Photoshop", "Illustrator", "Sketch"])
        case 2:
            addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: ["Leadership", "Time Management", "Negotiation"], skills2: ["Agile", "Scrum", "Kanban"])
        default:
            break
        }
    }
    
    private func addTitleLabel(to stack: UIStackView) {
        let titleLabel = UILabel()
        titleLabel.text = "Latest Updated Skills"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
    }
    
    private func addContentStack(to stack: UIStackView, title1: String, title2: String, skills1: [String], skills2: [String]) {
        addHStack(to: stack, title: title1, skills: skills1)
        addSpacing(to: stack, height: 16)
        addHStack(to: stack, title: title2, skills: skills2)
    }
    
    private func addHStack(to stack: UIStackView, title: String, skills: [String]) {
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
        showMoreButton.tag = title.hashValue  // Use the title's hash as a tag to identify which button was clicked

        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(showMoreButton)

        hStack.addArrangedSubview(headerStack)

        for skill in skills {
            let card = createSkillView(skillName: skill, borderColorName: "BTint200")
            card.translatesAutoresizingMaskIntoConstraints = false
            hStack.addArrangedSubview(card)
        }

        stack.addArrangedSubview(hStack)
    }

    
    private func addSpacing(to stack: UIStackView, height: CGFloat) {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(spacer)
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
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
        skillLabel.attributedText = NSAttributedString(
            string: skillName,
            attributes: TypographyRegular.body
        )
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
    
    @objc private func showMoreButtonTapped(_ sender: UIButton) {
        let detailVC = DetailSkillViewController()
        
        // Use the button's tag to identify which category was clicked
        if let title = sender.title(for: .normal) {
            detailVC.skillCategory = title
        }
        
        // Pass additional data if needed, e.g., skills by month
        detailVC.skills = getSkills(forCategory: detailVC.skillCategory)
        
        // Navigate to the detail view controller
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func getSkills(forCategory category: String?) -> [String] {
        // Fetch or generate skills based on the category and month
        // This is just a placeholder; you should implement the actual logic
        let skillsByMonth: [String: [String]] = [
            "Soft Skills": ["Communication", "Critical Thinking", "Public Speaking"],
            "Hard Skills": ["SwiftUI", "UIKit", "MVVM"]
        ]
        return skillsByMonth[category ?? ""] ?? []
    }
}
