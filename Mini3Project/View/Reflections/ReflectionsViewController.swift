import UIKit
import Combine
import SwiftData

class ReflectionsViewController: UIViewController {
    private var viewModel: ReflectionsViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var headerContainer: UIView = UIView()
    private lazy var headerImageView: UIImageView = UIImageView()
    
    private lazy var reflectionsContainer: UIView = UIView()
    
    private lazy var titleLabel: UILabel = UILabel()
    
    private lazy var dateView: UIView = UIView()
    private lazy var dateLabel: UILabel = UILabel()
    
    private lazy var reflectionsStack: UIStackView = UIStackView()
    private lazy var reflectionsScrollView: UIScrollView = UIScrollView()
    
    private lazy var reflectionsEmptyStateContainer: UIView = UIView()
    private lazy var reflectionsEmptyStateImageView: UIImageView = UIImageView()
    private lazy var reflectionsEmptyStateLabel: UILabel = UILabel()
    
    init(viewModel: ReflectionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        viewModel.generateData()
        viewModel.loadData()
        
        setupView()
        setupHeaderView()
        setupRelfectionsView()
        setupTitleLabel()
        setupDateLabel()
        setupReflections()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "HeaderBG")
    }
    
    private func setupHeaderView() {
        headerImageView.image = UIImage(named: "ReflectionsHeader")
        headerImageView.frame = CGRect(x: 0, y: 0, width: 393, height: 200)
        headerImageView.layer.cornerRadius = 50
        headerImageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        headerImageView.layer.masksToBounds = true
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerContainer.backgroundColor = .systemBackground
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        headerContainer.addSubview(headerImageView)
        view.addSubview(headerContainer)
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 200),
            
            headerImageView.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
        ])
    }
    
    private func setupRelfectionsView() {
        reflectionsContainer.backgroundColor = .systemBackground
        reflectionsContainer.layer.cornerRadius = 50
        reflectionsContainer.layer.maskedCorners = [.layerMaxXMinYCorner]
        reflectionsContainer.layer.masksToBounds = true
        reflectionsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reflectionsContainer)
        
        NSLayoutConstraint.activate([
            reflectionsContainer.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
            reflectionsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reflectionsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reflectionsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.attributedText = NSAttributedString(
            string: "Reflections",
            attributes: TypographyEmphasized.largeTitle
        )
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: reflectionsContainer.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: reflectionsContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: reflectionsContainer.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupDateLabel() {
        dateView.backgroundColor = UIColor(named: "BTint100")
        dateView.layer.cornerRadius = 24
        dateView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateView.addGestureRecognizer(tapGesture)
        
        dateLabel.attributedText = NSAttributedString(
            string:  Utilities.getDateFormatted(from: Date(), format: "MMMM, yyyy"),
            attributes: TypographyRegular.headline
        )
        dateLabel.textColor = UIColor(named: "MascotWhite")
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: "MascotWhite")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentStackView = UIStackView(arrangedSubviews: [iconImageView, dateLabel])
        contentStackView.axis = .horizontal
        contentStackView.spacing = 12
        contentStackView.alignment = .center
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        dateView.addSubview(contentStackView)
        view.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22),
            
            dateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 268),
            dateView.heightAnchor.constraint(equalToConstant: 48),
            
            contentStackView.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
        ])
    }
    
    private func setupReflections() {
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
        
        if viewModel.filteredReflections.isEmpty {
            let emptyStateView = EmptyStateView(imageName: "MascotSad", desc: "You don't have any reflections this month")
            
            reflectionsStack.addArrangedSubview(emptyStateView)
        } else {
            for reflection in viewModel.filteredReflections {
                let reflectionTopicLabel = UILabel()
                reflectionTopicLabel.attributedText = NSAttributedString(
                    string: reflection.topic,
                    attributes: TypographyRegular.headline
                )
                reflectionTopicLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let reflectionSoftSkillsLabel = UILabel()
                let softSkillsText: String
                let softSkills = Utilities.getReflectionSkillsName(from: reflection, filteringBy: "softskill")
                if softSkills.isEmpty {
                    softSkillsText = "Soft skills: -"
                } else {
                    let skillNames = softSkills.joined(separator: ", ")
                    softSkillsText = "Soft skills: \(skillNames)"
                }
                reflectionSoftSkillsLabel.attributedText = NSAttributedString(
                    string: softSkillsText,
                    attributes: TypographyRegular.footnote
                )
                reflectionSoftSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let reflectionHardSkillsLabel = UILabel()
                let hardSkillsText: String
                let hardSkills = Utilities.getReflectionSkillsName(from: reflection, filteringBy: "hardskill")
                if hardSkills.isEmpty {
                    hardSkillsText = "Hard skills: -"
                } else {
                    let skillNames = hardSkills.joined(separator: ", ")
                    hardSkillsText = "Hard skills: \(skillNames)"
                }
                reflectionHardSkillsLabel.attributedText = NSAttributedString(
                    string: hardSkillsText,
                    attributes: TypographyRegular.footnote
                )
                reflectionHardSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let horizontalLineView: UIView = UIView()
                horizontalLineView.backgroundColor = .separator
                horizontalLineView.translatesAutoresizingMaskIntoConstraints = false
                
                let reflectionDateLabel = UILabel()
                reflectionDateLabel.attributedText = NSAttributedString(
                    string: Utilities.getDateFormatted(from: reflection.createdAt, format: "dd MMMM yyyy"),
                    attributes: TypographyRegular.caption1
                )
                reflectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let reflectionView = UIView()
                reflectionView.backgroundColor = UIColor(named: "FilledCardPurp")
                reflectionView.layer.cornerRadius = 20
                if let borderColor = UIColor(named: "BTint100")?.cgColor {
                    reflectionView.layer.borderColor = borderColor
                }
                reflectionView.layer.borderWidth = 2
                if let shadowColor = UIColor(named: "BTint100")?.cgColor {
                    reflectionView.layer.shadowColor = shadowColor
                    reflectionView.layer.shadowOpacity = 1.0
                    reflectionView.layer.shadowOffset = CGSize(width: 0, height: 4)
                    reflectionView.layer.shadowRadius = 0
                }
                reflectionView.translatesAutoresizingMaskIntoConstraints = false
                
                let reflectionDetailStack = UIStackView(arrangedSubviews: [reflectionTopicLabel, reflectionSoftSkillsLabel, reflectionHardSkillsLabel, horizontalLineView, reflectionDateLabel])
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
    }
    
    
    // MARK: - Actions
    @objc private func goToReflectionDetail(_ sender: UITapGestureRecognizer) {
        guard let reflectionView = sender.view else { return }
        
        guard let index = reflectionsStack.arrangedSubviews.firstIndex(of: reflectionView) else { return }
        
        let reflection = viewModel.filteredReflections[index]
        
        let reflectionDetailViewModel = ReflectionDetailViewModel(reflection: reflection)
        let reflectionDetailViewController = ReflectionDetailViewController(viewModel: reflectionDetailViewModel)
        reflectionDetailViewController.title = "Reflection Detail"
        
        navigationController?.pushViewController(reflectionDetailViewController, animated: true)
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
                self?.dateLabel.text = Utilities.getDateFormatted(from: newDate, format: "MMMM, yyyy")
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
