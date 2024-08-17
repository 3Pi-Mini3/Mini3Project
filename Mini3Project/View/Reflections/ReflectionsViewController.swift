import UIKit
import Combine

class ReflectionsViewController: UIViewController {
    // MARK: - UI Elements
    private let reflectionButton: UIButton = UIButton()
    private let dateLabel: UILabel = UILabel()
    
    var viewModel: ReflectionsViewModel = ReflectionsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureReflectionButton()
        configureDateLabel()
        bindViewModel()
    }
    
    // MARK: - View Configuration
    private func configureView() {
        view.backgroundColor = .white
        title = "Reflections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureReflectionButton() {
        reflectionButton.configuration = .filled()
        reflectionButton.configuration?.baseBackgroundColor = .systemBlue
        reflectionButton.configuration?.title = "Reflection"
        
        reflectionButton.addTarget(self, action: #selector(goToReflectionDetail), for: .touchUpInside)
        
        view.addSubview(reflectionButton)
        reflectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reflectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reflectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            reflectionButton.widthAnchor.constraint(equalToConstant: 200),
            reflectionButton.heightAnchor.constraint(equalToConstant: 50)
        ])    }
    
    private func configureDateLabel() {
        dateLabel.text = getCurrentDateFormatted()
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dateLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: reflectionButton.topAnchor, constant: -20)
        ])
    }
    
    // MARK: - Helpers
    private func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: viewModel.currentDate)
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
        viewModel.$currentDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newDate in
                self?.dateLabel.text = self?.getCurrentDateFormatted()
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
