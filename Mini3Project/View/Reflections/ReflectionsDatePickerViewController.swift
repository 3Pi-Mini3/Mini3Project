import UIKit

class ReflectionsDatePickerViewController: UIViewController {
    var currentDate: Date?
    
    private let datePickerStack = UIStackView()
    private let yearPickerStack = UIStackView()
    private let monthPickerStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDatePickerStack()
        configureYearPicker()
        configureMonthPicker()
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureDatePickerStack() {
        datePickerStack.axis = .vertical
        datePickerStack.distribution = .equalSpacing
        datePickerStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(datePickerStack)
        
        NSLayoutConstraint.activate([
            datePickerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            datePickerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            datePickerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            datePickerStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        ])
    }
    
    // MARK: - Year Picker Configuration
    
    private func configureYearPicker() {
        let yearLabel = createYearLabel(text: "2024")
        let leftArrowButton = createArrowButton(direction: "left", symbolSize: 22)
        let rightArrowButton = createArrowButton(direction: "right", symbolSize: 22)
        
        leftArrowButton.addTarget(self, action: #selector(previousYear), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(nextYear), for: .touchUpInside)
        
        let yearPickerStackView = UIStackView(arrangedSubviews: [leftArrowButton, yearLabel, rightArrowButton])
        yearPickerStackView.axis = .horizontal
        yearPickerStackView.distribution = .equalSpacing
        
        yearPickerStack.addArrangedSubview(yearPickerStackView)
        datePickerStack.addArrangedSubview(yearPickerStack)
    }
    
    private func createYearLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createArrowButton(direction: String, symbolSize: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        let imageName: String
        switch direction {
        case "left":
            imageName = "arrowtriangle.left.fill"
        case "right":
            imageName = "arrowtriangle.right.fill"
        default:
            imageName = "arrowtriangle.left.fill"
        }
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: symbolSize, weight: .regular)
        let image = UIImage(systemName: imageName, withConfiguration: symbolConfiguration)
        
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - Month Picker Configuration
    
    private func configureMonthPicker() {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let monthLabels = months.map { createMonthLabelView(with: $0) }
        
        monthPickerStack.axis = .vertical
        monthPickerStack.spacing = 12
        monthPickerStack.translatesAutoresizingMaskIntoConstraints = false
        
        for row in 0..<3 {
            let rowLabels = Array(monthLabels[row * 4..<(row * 4 + 4)])
            let rowStackView = UIStackView(arrangedSubviews: rowLabels)
            rowStackView.axis = .horizontal
            rowStackView.spacing = 12
            rowStackView.distribution = .fillEqually
            
            monthPickerStack.addArrangedSubview(rowStackView)
        }
        
        datePickerStack.addArrangedSubview(monthPickerStack)
    }
    
    private func createMonthLabelView(with month: String) -> UIView {
        let labelView = UIView()
        labelView.backgroundColor = .systemBlue
        labelView.layer.cornerRadius = 4
        
        let label = UILabel()
        label.text = month
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -12),
            label.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -8)
        ])
        
        return labelView
    }
    
    // MARK: - Actions
    
    @objc private func previousYear() {
        // Handle navigation to the previous year
    }
    
    @objc private func nextYear() {
        // Handle navigation to the next year
    }
}
