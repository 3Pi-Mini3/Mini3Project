//
//  SkillsViewController.swift
//  Mini3Project
//
//  Created by Agfi on 18/08/24.
//

import UIKit

class SkillsViewController: UIViewController {
    // Segmented Control
    let segmentedControl: UISegmentedControl = {
        let items = ["Coder", "Design", "Product"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false

        control.backgroundColor = UIColor(named: "BTint200")!.withAlphaComponent(0.3)
        control.selectedSegmentTintColor = UIColor(named: "BTint100")
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        return control
    }()

    let skillsContentViewController = SkillsContentViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Skills"
        view.backgroundColor = .white

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        setupSegmentedControl()
        setupContentViewController()
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    func setupSegmentedControl() {
        view.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupContentViewController() {
        addChild(skillsContentViewController)
        skillsContentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skillsContentViewController.view)
        NSLayoutConstraint.activate([
            skillsContentViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            skillsContentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skillsContentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skillsContentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        skillsContentViewController.didMove(toParent: self)
        skillsContentViewController.updateContent(forSegment: segmentedControl.selectedSegmentIndex)
    }

    @objc func segmentChanged(_ sender: UISegmentedControl) {
        skillsContentViewController.updateContent(forSegment: sender.selectedSegmentIndex)
    }
}
