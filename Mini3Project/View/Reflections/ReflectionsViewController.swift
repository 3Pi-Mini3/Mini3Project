import UIKit
import Combine
import SwiftData

enum Section {
    case reflections
}

class ReflectionsViewController: UIViewController {
    // MARK: - UI Elements
    private let headerView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    
    private let reflectionsView: UIView = UIView()
    
    private let titleLabel: UILabel = UILabel()
    
    private let dateView: UIView = UIView()
    private let dateLabel: UILabel = UILabel()
    private let reflectionsStack: UIStackView = UIStackView()
    private let reflectionsScrollView: UIScrollView = UIScrollView()
    
    var viewModel: ReflectionsViewModel = ReflectionsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.generateData()
        viewModel.loadData()
        
        configureView()
        configureHeaderView()
        configureRelfectionsView()
        configureTitleLabel()
        configureDateLabel()
        configureReflections()
        
        bindViewModel()
    }
    
    // MARK: - View Configuration
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
        
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
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
        
        view.addSubview(reflectionsView)
        
        NSLayoutConstraint.activate([
            reflectionsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            reflectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reflectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reflectionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        let titleAttributedString = NSAttributedString(
            string: "Reflections",
            attributes: TypographyEmphasized.largeTitle
        )
        titleLabel.attributedText = titleAttributedString
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: reflectionsView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: reflectionsView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: reflectionsView.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureDateLabel() {
        dateView.backgroundColor = UIColor(named: "Bluemarine")
        dateView.layer.cornerRadius = 24
        dateView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateView.addGestureRecognizer(tapGesture)
        
        dateLabel.text = viewModel.getCurrentDateFormatted()
        dateLabel.textColor = UIColor(named: "White")
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: "White")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentStackView = UIStackView(arrangedSubviews: [iconImageView, dateLabel])
        contentStackView.axis = .horizontal
        contentStackView.spacing = 12
        contentStackView.alignment = .center
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        dateView.addSubview(contentStackView)
        view.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 268),
            dateView.heightAnchor.constraint(equalToConstant: 48),
            
            contentStackView.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
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
            let topicAttributedString = NSAttributedString(
                string: reflection.topic,
                attributes: TypographyRegular.headline
            )
            reflectionTopicLabel.attributedText = topicAttributedString
            reflectionTopicLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionHardSkillsLabel = UILabel()
            var hardSkillsString = ""
            if let skills = reflection.skill {
                let hardSkills = skills
                    .filter { $0.type == "hardskill" }
                    .map { $0.name }
                
                if hardSkills.isEmpty {
                    hardSkillsString = "Hard skills : -"
                } else {
                    hardSkillsString = "Hard skills : \(hardSkills.joined(separator: ", "))"
                }
            } else {
                hardSkillsString = "Hard skills : -"
            }
            let hardSkillsAttributedString = NSAttributedString(
                string: hardSkillsString,
                attributes: TypographyRegular.footnote
            )
            reflectionHardSkillsLabel.attributedText = hardSkillsAttributedString
            reflectionHardSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionSoftSkillsLabel = UILabel()
            var softSkillsString = ""
            if let skills = reflection.skill {
                let softSkills = skills
                    .filter { $0.type == "softskill" }
                    .map { $0.name }
                
                if softSkills.isEmpty {
                    softSkillsString = "Soft skills : -"
                } else {
                    softSkillsString = "Soft skills : \(softSkills.joined(separator: ", "))"
                }
            } else {
                softSkillsString = "Hard skills : -"
            }
            let softSkillsAttributedString = NSAttributedString(
                string: softSkillsString,
                attributes: TypographyRegular.footnote
            )
            reflectionSoftSkillsLabel.attributedText = softSkillsAttributedString
            reflectionSoftSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalLineView: UIView = UIView()
            horizontalLineView.backgroundColor = .separator
            horizontalLineView.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDateLabel = UILabel()
            reflectionDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            let dateAttributedString = NSAttributedString(
                string:  viewModel.getReflectionDateFormatted(reflection: reflection),
                attributes: TypographyRegular.caption1
            )
            reflectionDateLabel.attributedText = dateAttributedString
            reflectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionView = UIView()
            reflectionView.backgroundColor = .systemGray6
            reflectionView.layer.cornerRadius = 20

            if let borderColor = UIColor(named: "Bluemarine")?.cgColor {
                reflectionView.layer.borderColor = borderColor
            }

            reflectionView.layer.borderWidth = 2
            
            if let shadowColor = UIColor(named: "Bluemarine")?.cgColor {
                reflectionView.layer.shadowColor = shadowColor
                reflectionView.layer.shadowOpacity = 1.0
                reflectionView.layer.shadowOffset = CGSize(width: 0, height: 4)
                reflectionView.layer.shadowRadius = 0
            }
            
            reflectionView.translatesAutoresizingMaskIntoConstraints = false
            
            let reflectionDetailStack = UIStackView(arrangedSubviews: [reflectionTopicLabel, reflectionHardSkillsLabel, reflectionSoftSkillsLabel, horizontalLineView, reflectionDateLabel])
            reflectionDetailStack.axis = .vertical
            reflectionDetailStack.spacing = 16
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
            popover.sourceView = dateView
            popover.sourceRect = dateView.bounds
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
