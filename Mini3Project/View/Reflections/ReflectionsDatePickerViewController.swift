import UIKit

class ReflectionsDatePickerViewController: UIViewController {
    var viewModel: ReflectionsViewModel?
    
    private let datePickerStack = UIStackView()
    
    private let yearPickerStack = UIStackView()
    private let yearLabel = UILabel()
    private let leftArrowButton = UIButton()
    private let rightArrowButton = UIButton()
    
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
        datePickerStack.spacing = 24
        datePickerStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(datePickerStack)
        
        NSLayoutConstraint.activate([
            datePickerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            datePickerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            datePickerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    // MARK: - Year Picker Configuration
    
    private func configureYearPicker() {
        guard let viewModel = viewModel else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: viewModel.currentDate)
        
        yearLabel.text = yearString
        yearLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        yearLabel.textColor = .black
        yearLabel.textAlignment = .center
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftArrowButton.setImage(UIImage(systemName: "arrowtriangle.left.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        leftArrowButton.tintColor = .black
        leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
        leftArrowButton.addTarget(self, action: #selector(previousYear), for: .touchUpInside)
        
        
        rightArrowButton.setImage(UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        rightArrowButton.tintColor = .black
        rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowButton.addTarget(self, action: #selector(nextYear), for: .touchUpInside)
        
        let yearPickerStackView = UIStackView(arrangedSubviews: [leftArrowButton, yearLabel, rightArrowButton])
        yearPickerStackView.axis = .horizontal
        yearPickerStackView.distribution = .equalSpacing
        
        yearPickerStack.addArrangedSubview(yearPickerStackView)
        datePickerStack.addArrangedSubview(yearPickerStack)
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
        
        updateMonthLabels()
    }
    
    private func createMonthLabelView(with month: String) -> UIView {
        let labelView = UIView()
        
        guard let viewModel = viewModel else { return UIView() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let currentMonth = dateFormatter.string(from: viewModel.currentDate)
        
        if month == currentMonth {
            labelView.backgroundColor = .systemBlue
        } else {
            labelView.backgroundColor = .clear
        }
        
        labelView.layer.cornerRadius = 4
        
        let label = UILabel()
        label.text = month
        
        if month == currentMonth {
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        } else {
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.addSubview(label)
        
        // Add tap gesture recognizer to the label view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(monthTapped(_:)))
        labelView.addGestureRecognizer(tapGesture)
        
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
        guard let viewModel = viewModel else { return }
        
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .year, value: -1, to: viewModel.currentDate) {
            viewModel.currentDate = newDate
            updateYearLabel()
        }
    }
    
    @objc private func nextYear() {
        guard let viewModel = viewModel else { return }
        
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .year, value: 1, to: viewModel.currentDate) {
            viewModel.currentDate = newDate
            updateYearLabel()
        }
    }
    
    @objc private func monthTapped(_ sender: UITapGestureRecognizer) {
        guard let labelView = sender.view,
              let label = labelView.subviews.first(where: { $0 is UILabel }) as? UILabel,
              let monthText = label.text,
              let viewModel = viewModel else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: viewModel.currentDate)
        
        // Create new date with selected month and current year
        let newDateString = "\(monthText) \(components.year!)"
        dateFormatter.dateFormat = "MMM yyyy"
        if let newDate = dateFormatter.date(from: newDateString) {
            viewModel.currentDate = newDate
            updateMonthLabels()
        }
    }
    
    private func updateYearLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: viewModel?.currentDate ?? Date())
        
        yearLabel.text = yearString
    }
    
    private func updateMonthLabels() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let currentMonth = dateFormatter.string(from: viewModel?.currentDate ?? Date())
        
        for subview in monthPickerStack.arrangedSubviews {
            if let stackView = subview as? UIStackView {
                for monthView in stackView.arrangedSubviews {
                    if let label = monthView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                        let isSelected = label.text == currentMonth
                        monthView.backgroundColor = isSelected ? .systemBlue : .clear
                        label.textColor = isSelected ? .white : .black
                        label.font = isSelected ? UIFont.systemFont(ofSize: 17, weight: .semibold) : UIFont.systemFont(ofSize: 17, weight: .regular)
                    }
                }
            }
        }
    }
}
