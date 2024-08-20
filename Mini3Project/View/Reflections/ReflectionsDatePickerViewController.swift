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
        view.backgroundColor = .systemBackground
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
    
    private func configureYearPicker() {
        guard let viewModel = viewModel else { return }
        
        let yearString = viewModel.getCurrentYear()
        
        yearLabel.text = yearString
        let yearAttributedString = NSAttributedString(
            string: yearString,
            attributes: TypographyRegular.headline
        )
        yearLabel.attributedText = yearAttributedString
        yearLabel.textColor = UIColor(named: "Black")
        yearLabel.textAlignment = .center
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftArrowButton.setImage(UIImage(systemName: "arrowtriangle.left.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        leftArrowButton.tintColor = UIColor(named: "BTint100")
        leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
        leftArrowButton.addTarget(self, action: #selector(previousYear), for: .touchUpInside)
        
        rightArrowButton.setImage(UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        rightArrowButton.tintColor = UIColor(named: "BTint100")
        rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowButton.addTarget(self, action: #selector(nextYear), for: .touchUpInside)
        
        let yearPickerStackView = UIStackView(arrangedSubviews: [leftArrowButton, yearLabel, rightArrowButton])
        yearPickerStackView.axis = .horizontal
        yearPickerStackView.distribution = .equalSpacing
        
        yearPickerStack.addArrangedSubview(yearPickerStackView)
        datePickerStack.addArrangedSubview(yearPickerStack)
    }
    
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
        labelView.backgroundColor = .clear
        labelView.layer.cornerRadius = 4
        
        let label = UILabel()
        label.text = month
        label.textColor = UIColor(named: "Black")
        let labelAttributedString = NSAttributedString(
            string: month,
            attributes: TypographyRegular.body
        )
        label.attributedText = labelAttributedString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(monthTapped(_:)))
        labelView.addGestureRecognizer(tapGesture)
        
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
        guard let viewModel = viewModel else { return }
        
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .year, value: -1, to: viewModel.date) {
            viewModel.date = newDate
            updateYearLabel()
        }
    }
    
    @objc private func nextYear() {
        guard let viewModel = viewModel else { return }
        
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .year, value: 1, to: viewModel.date) {
            viewModel.date = newDate
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
        let components = calendar.dateComponents([.year], from: viewModel.date)
        
        let newDateString = "\(monthText) \(components.year!)"
        dateFormatter.dateFormat = "MMM yyyy"
        if let newDate = dateFormatter.date(from: newDateString) {
            viewModel.date = newDate
            updateMonthLabels()
        }
    }
    
    private func updateYearLabel() {
        guard let viewModel = viewModel else { return }
        
        let yearString = viewModel.getCurrentYear()
        yearLabel.text = yearString
    }
    
    private func updateMonthLabels() {
        guard let viewModel = viewModel else { return }
        
        let currentMonth = viewModel.getCurrentMonth()
        
        for subview in monthPickerStack.arrangedSubviews {
            if let stackView = subview as? UIStackView {
                for monthView in stackView.arrangedSubviews {
                    if let label = monthView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                        let isSelected = label.text == currentMonth
                        monthView.backgroundColor = isSelected ? UIColor(named: "Bluemarine") : .clear
                        label.textColor = isSelected ? .white : UIColor(named: "Black")
                        label.font = isSelected ? UIFont.systemFont(ofSize: 17, weight: .semibold) : UIFont.systemFont(ofSize: 17, weight: .regular)
                    }
                }
            }
        }
    }
}
