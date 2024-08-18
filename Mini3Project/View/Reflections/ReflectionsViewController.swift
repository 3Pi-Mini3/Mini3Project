import UIKit
import Combine
import SwiftData

enum Section {
    case reflections
}

class ReflectionsViewController: UIViewController {
    // MARK: - UI Elements
    private let dateStack: UIStackView = UIStackView()
    private let dateLabel: UILabel = UILabel()
    private let reflectionsStack: UIStackView = UIStackView()
    
    var viewModel: ReflectionsViewModel = ReflectionsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDateLabel()
        configureReflections()
        bindViewModel()
    }
    
    // MARK: - View Configuration
    private func configureView() {
        title = "Reflections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDateLabel() {
        dateStack.backgroundColor = UIColor(named: "BTint100")
        dateStack.layer.cornerRadius = 8
        dateStack.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateStack.addGestureRecognizer(tapGesture)
        
        view.addSubview(dateStack)
        
        dateLabel.text = viewModel.getCurrentDateFormatted()
        dateLabel.layer.cornerRadius = 8
        dateLabel.layer.masksToBounds = true
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateStack.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateStack.widthAnchor.constraint(equalToConstant: 268),
            dateStack.heightAnchor.constraint(equalToConstant: 48),
            dateStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    private func configureReflections() {
        reflectionsStack.axis = .vertical
        reflectionsStack.spacing = 16
        reflectionsStack.translatesAutoresizingMaskIntoConstraints = false
        
        updateReflections()
        view.addSubview(reflectionsStack)
        
        NSLayoutConstraint.activate([
            reflectionsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reflectionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            reflectionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            reflectionsStack.topAnchor.constraint(equalTo: dateStack.bottomAnchor, constant: 32)
        ])
    }
    
    private func updateReflections() {
        reflectionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        viewModel.filterReflectionsByMonthAndYear()
        
        for reflection in viewModel.filteredReflections {
            let reflectionTopicLabel = UILabel()
            reflectionTopicLabel.text = reflection.topic
            reflectionTopicLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionHardSkillsLabel = UILabel()
            if let skills = reflection.skill {
                let hardSkills = skills
                    .filter { $0.type == "hardskill" }
                    .map { $0.name }
                
                let hardSkillsString = hardSkills.joined(separator: ", ")
                
                
                reflectionHardSkillsLabel.text = "Hard skills : \(hardSkillsString)"
            } else {
                reflectionHardSkillsLabel.text = "Hard skills : -"
            }
            reflectionHardSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionSoftSkillsLabel = UILabel()
            if let skills = reflection.skill {
                let softSkills = skills
                    .filter { $0.type == "softskill" }
                    .map { $0.name }
                
                let softSkillsString = softSkills.joined(separator: ", ")
                
                reflectionSoftSkillsLabel.text = "Soft skills : \(softSkillsString)"
            } else {
                reflectionHardSkillsLabel.text = "Soft skills : -"
            }
            reflectionSoftSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDateLabel = UILabel()
            reflectionDateLabel.text = viewModel.getReflectionDateFormatted(reflection: reflection)
            reflectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionStack = UIStackView()
            reflectionStack.backgroundColor = .systemGray5
            reflectionStack.layer.cornerRadius = 8
            reflectionStack.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDetailStack = UIStackView(arrangedSubviews: [reflectionTopicLabel, reflectionHardSkillsLabel, reflectionSoftSkillsLabel, reflectionDateLabel])
            reflectionDetailStack.axis = .vertical
            reflectionDetailStack.spacing = 8
            reflectionDetailStack.translatesAutoresizingMaskIntoConstraints = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToReflectionDetail))
            reflectionStack.addGestureRecognizer(tapGesture)
            
            reflectionStack.addSubview(reflectionDetailStack)
            reflectionsStack.addArrangedSubview(reflectionStack)
            
            NSLayoutConstraint.activate([
                reflectionDetailStack.topAnchor.constraint(equalTo: reflectionStack.topAnchor, constant: 16),
                reflectionDetailStack.leadingAnchor.constraint(equalTo: reflectionStack.leadingAnchor, constant: 16),
                reflectionDetailStack.trailingAnchor.constraint(equalTo: reflectionStack.trailingAnchor, constant: -16),
                reflectionDetailStack.bottomAnchor.constraint(equalTo: reflectionStack.bottomAnchor, constant: -16),
                
                reflectionStack.leadingAnchor.constraint(equalTo: reflectionsStack.leadingAnchor),
                reflectionStack.trailingAnchor.constraint(equalTo: reflectionsStack.trailingAnchor),
            ])
        }
    }
    
    // MARK: - Actions
    @objc private func goToReflectionDetail() {
        let detailViewController = ReflectionDetailViewController()
        detailViewController.title = "Reflection Detail"
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc private func openDatePicker() {
        let datePickerViewController = ReflectionsDatePickerViewController()
        datePickerViewController.modalPresentationStyle = .popover
        datePickerViewController.preferredContentSize = CGSize(width: 320, height: 248)
        datePickerViewController.viewModel = viewModel
        
        if let popover = datePickerViewController.popoverPresentationController {
            popover.sourceView = dateLabel
            popover.sourceRect = dateLabel.bounds
            popover.permittedArrowDirections = .up
            popover.delegate = self
        }
        
        present(datePickerViewController, animated: true, completion: nil)
    }
    
    private func bindViewModel() {
        viewModel.$date
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newDate in
                self?.dateLabel.text = self?.viewModel.getCurrentDateFormatted()
                self?.updateReflections()
            }
            .store(in: &cancellables)
    }
}


// MARK: - UIPopoverPresentationControllerDelegate
extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
