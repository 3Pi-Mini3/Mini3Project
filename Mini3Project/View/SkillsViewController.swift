//
//  SkillsViewController.swift
//  Mini3Project
//
//  Created by Agfi on 20/08/24.
//

//
//  SkillsViewController.swift
//  Mini3Project
//
//  Created by Agfi on 18/08/24.
//

import UIKit

class SkillsViewController: UIViewController {
    private let headerView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    
    private let reflectionsView: UIView = UIView()
    
    private let titleLabel: UILabel = UILabel()
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
        
        configureView()
        configureHeaderView()
        configureRelfectionsView()
        configureTitleLabel()
        
        setupSegmentedControl()
        setupContentViewController()
        
        // Add this line to load the initial content
        skillsContentViewController.updateContent(forSegment: segmentedControl.selectedSegmentIndex)
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray6
    }
    
    private func configureHeaderView() {
        headerView.backgroundColor = .systemBackground
        
        imageView.image = UIImage(named: "ReflectionsHeader")
        imageView.frame = CGRect(x: 0, y: 0, width: 393, height: 200)
        imageView.layer.cornerRadius = 50
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(imageView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])
    }
    
    private func configureRelfectionsView() {
        reflectionsView.backgroundColor = .systemBackground
        reflectionsView.layer.cornerRadius = 50
        reflectionsView.layer.maskedCorners = [.layerMaxXMinYCorner]
        reflectionsView.layer.masksToBounds = true
        reflectionsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        let titleAttributedString = NSAttributedString(
            string: "Skills",
            attributes: TypographyEmphasized.largeTitle
        )
        titleLabel.attributedText = titleAttributedString
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupContentViewController() {
        addChild(skillsContentViewController)
        skillsContentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        skillsContentViewController.didMove(toParent: self)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        skillsContentViewController.updateContent(forSegment: sender.selectedSegmentIndex)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            titleLabel,
            segmentedControl,
            skillsContentViewController.view
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        reflectionsView.addSubview(stackView)
        view.addSubview(reflectionsView)
        
        NSLayoutConstraint.activate([
            reflectionsView.topAnchor.constraint(equalTo: view.topAnchor),
            reflectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reflectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reflectionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: reflectionsView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: reflectionsView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: reflectionsView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: reflectionsView.bottomAnchor)
        ])
    }
}
