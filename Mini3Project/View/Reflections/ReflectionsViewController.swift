import UIKit
import Combine
import SwiftData

enum Section {
    case reflections
}

class ReflectionsViewController: UIViewController {
    // MARK: - UI Elements
    private let dateView: UIView = UIView()
    private let dateLabel: UILabel = UILabel()
    private let reflectionsStack: UIStackView = UIStackView()
    private let reflectionsScrollView: UIScrollView = UIScrollView()
    
    var viewModel: ReflectionsViewModel = ReflectionsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        viewModel.generateData()
        viewModel.loadData()
        configureView()
        configureDateLabel()
        configureReflections()
        bindViewModel()
    }
    
    // MARK: - View Configuration
    private func configureView() {
        view.backgroundColor = .systemBackground
        self.parent?.title = "Reflections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDateLabel() {
        dateView.backgroundColor = UIColor(named: "BTint100")
        dateView.layer.cornerRadius = 8
        dateView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateView.addGestureRecognizer(tapGesture)
        
        dateLabel.text = viewModel.getCurrentDateFormatted()
        dateLabel.layer.cornerRadius = 8
        dateLabel.layer.masksToBounds = true
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateView.addSubview(dateLabel)
        view.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 268),
            dateView.heightAnchor.constraint(equalToConstant: 48),
            
            dateLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
        ])
    }
    
    private func configureReflections() {
        reflectionsScrollView.showsVerticalScrollIndicator = false
        reflectionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        reflectionsStack.axis = .vertical
        reflectionsStack.spacing = 20
        reflectionsStack.translatesAutoresizingMaskIntoConstraints = false
        
        updateReflections()
        
        view.addSubview(reflectionsScrollView)
        reflectionsScrollView.addSubview(reflectionsStack)
        
        NSLayoutConstraint.activate([
            reflectionsScrollView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 32),
            reflectionsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            reflectionsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            reflectionsScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            reflectionsStack.topAnchor.constraint(equalTo: reflectionsScrollView.topAnchor),
            reflectionsStack.leadingAnchor.constraint(equalTo: reflectionsScrollView.leadingAnchor),
            reflectionsStack.trailingAnchor.constraint(equalTo: reflectionsScrollView.trailingAnchor),
            reflectionsStack.bottomAnchor.constraint(equalTo: reflectionsScrollView.bottomAnchor),
            reflectionsStack.widthAnchor.constraint(equalTo: reflectionsScrollView.widthAnchor)
        ])
    }
    
    private func updateReflections() {
        reflectionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        viewModel.filterReflectionsByMonthAndYear()
        
        for reflection in viewModel.filteredReflections {
            let reflectionTopicLabel = UILabel()
            reflectionTopicLabel.text = reflection.topic
            reflectionTopicLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            reflectionTopicLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionHardSkillsLabel = UILabel()
            reflectionHardSkillsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            if let skills = reflection.skill {
                let hardSkills = skills
                    .filter { $0.type == "hardskill" }
                    .map { $0.name }
                
                let hardSkillsString = hardSkills.isEmpty ? "-" : hardSkills.joined(separator: ", ")
                reflectionHardSkillsLabel.text = "Hard skills : \(hardSkillsString)"
            } else {
                reflectionHardSkillsLabel.text = "Hard skills : -"
            }
            reflectionHardSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionSoftSkillsLabel = UILabel()
            reflectionSoftSkillsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            if let skills = reflection.skill {
                let softSkills = skills
                    .filter { $0.type == "softskill" }
                    .map { $0.name }
                
                let softSkillsString = softSkills.isEmpty ? "-" : softSkills.joined(separator: ", ")
                reflectionSoftSkillsLabel.text = "Soft skills : \(softSkillsString)"
            } else {
                reflectionSoftSkillsLabel.text = "Soft skills : -"
            }
            reflectionSoftSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalLineView: UIView = UIView()
            horizontalLineView.backgroundColor = .separator
            horizontalLineView.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDateLabel = UILabel()
            reflectionDateLabel.text = viewModel.getReflectionDateFormatted(reflection: reflection)
            reflectionDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            reflectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionView = UIView()
            reflectionView.backgroundColor = .systemGray6
            reflectionView.layer.cornerRadius = 8
            reflectionView.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDetailStack = UIStackView(arrangedSubviews: [reflectionTopicLabel, reflectionHardSkillsLabel, reflectionSoftSkillsLabel, horizontalLineView, reflectionDateLabel])
            reflectionDetailStack.axis = .vertical
            reflectionDetailStack.spacing = 12
            reflectionDetailStack.translatesAutoresizingMaskIntoConstraints = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToReflectionDetail(_:)))
            reflectionView.addGestureRecognizer(tapGesture)
            
            reflectionView.addSubview(reflectionDetailStack)
            reflectionsStack.addArrangedSubview(reflectionView)
            
            NSLayoutConstraint.activate([
                reflectionView.leadingAnchor.constraint(equalTo: reflectionsStack.leadingAnchor),
                reflectionView.trailingAnchor.constraint(equalTo: reflectionsStack.trailingAnchor),
                
                reflectionDetailStack.topAnchor.constraint(equalTo: reflectionView.topAnchor, constant: 16),
                reflectionDetailStack.leadingAnchor.constraint(equalTo: reflectionView.leadingAnchor, constant: 16),
                reflectionDetailStack.trailingAnchor.constraint(equalTo: reflectionView.trailingAnchor, constant: -16),
                reflectionDetailStack.bottomAnchor.constraint(equalTo: reflectionView.bottomAnchor, constant: -16),
                
                horizontalLineView.heightAnchor.constraint(equalToConstant: 1),
                horizontalLineView.leadingAnchor.constraint(equalTo: reflectionDetailStack.leadingAnchor),
                horizontalLineView.trailingAnchor.constraint(equalTo: reflectionDetailStack.trailingAnchor),
            ])
        }
    }
    
    
    // MARK: - Actions
    @objc private func goToReflectionDetail(_ sender: UITapGestureRecognizer) {
        guard let reflectionView = sender.view else { return }
        
        guard let index = reflectionsStack.arrangedSubviews.firstIndex(of: reflectionView) else { return }
        
        let reflection = viewModel.filteredReflections[index]
        
        let detailViewController = ReflectionDetailViewController()
        detailViewController.reflection = reflection
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
