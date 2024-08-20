//
//  SkillCardController.swift
//  Mini3Project
//
//  Created by Agfi on 19/08/24.
//

import UIKit

class SkillsContentViewController: UIViewController {

    private let hStackSpacing: CGFloat = 16
    private let cardHeight: CGFloat = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    func updateContent(forSegment segment: Int) {
        // Remove any previous subviews when switching content
        view.subviews.forEach { $0.removeFromSuperview() }

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .fill
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)
        
        // Constraints for the main stack
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16) // Adjust as needed
        ])

        addTitleLabel(to: mainStack)

        switch segment {
        case 0:
            // Coder content
            addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: ["Communication", "Critical Thinking", "Public Speaking"], skills2: ["SwiftUI", "UIKit", "MVVM"])
        case 1:
            // Design content
            addContentStack(to: mainStack, title1: "Soft Skills", title2: "Hard Skills", skills1: ["Creativity", "User Research", "Prototyping"], skills2: ["Photoshop", "Illustrator", "Sketch"])
        case 2:
            // Project Management content
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
        // Add Soft Skills HStack
        addHStack(to: stack, title: title1, skills: skills1)

        // Add Hard Skills HStack
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

        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(showMoreButton)

        hStack.addArrangedSubview(headerStack)

        for skill in skills {
            let card = CardView(content: skill)
            card.translatesAutoresizingMaskIntoConstraints = false
            hStack.addArrangedSubview(card)
            // Set a fixed height for the card
            card.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
        }

        stack.addArrangedSubview(hStack)
    }
}
