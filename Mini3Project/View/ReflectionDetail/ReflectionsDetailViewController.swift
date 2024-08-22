import UIKit

class ReflectionDetailViewController: UIViewController {
    var reflection: Reflection?
    
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let softSkillsContainer: UIStackView = UIStackView()
    private let softSkillsTitleLabel: UILabel = UILabel()
    private let softSkillsList: UIStackView = UIStackView()
    
    private let hardSkillsContainer: UIStackView = UIStackView()
    private let hardSkillsTitleLabel: UILabel = UILabel()
    private let hardSkillsList: UIStackView = UIStackView()
    
    private let summaryContainer: UIStackView = UIStackView()
    private let summaryTitleLabel: UILabel = UILabel()
    private let summaryBackgroundView: UIView = UIView()
    private let summaryTextLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScrollView()
        setupSoftSkillsSection()
        setupHardSkillsSection()
        setupSummarySection()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Skills Achieved"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.axis = .vertical
        contentView.spacing = 24
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setupSoftSkillsSection() {
        softSkillsContainer.axis = .vertical
        softSkillsContainer.spacing = 8
        softSkillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        softSkillsTitleLabel.attributedText = NSAttributedString(
            string: "Soft Skills",
            attributes: TypographyEmphasized.title2
        )
        softSkillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        softSkillsList.axis = .vertical
        softSkillsList.spacing = 8
        softSkillsList.translatesAutoresizingMaskIntoConstraints = false
        
        if let skills = reflection?.skill {
            let softSkills = skills
                .filter { $0.type == "softskill" }
                .map { $0.name }
            
            if softSkills.isEmpty {
                let textLabel = UILabel()
                textLabel.text = "You did not get any soft skills."
                textLabel.textColor = .systemGray2
                softSkillsList.addArrangedSubview(textLabel)
            } else {
                for skill in softSkills {
                    let skillView = createSkillView(skillName: skill)
                    softSkillsList.addArrangedSubview(skillView)
                }
            }
        }
        
        softSkillsContainer.addArrangedSubview(softSkillsTitleLabel)
        softSkillsContainer.addArrangedSubview(softSkillsList)
        contentView.addArrangedSubview(softSkillsContainer)
        
        NSLayoutConstraint.activate([
            softSkillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            softSkillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupHardSkillsSection() {
        hardSkillsContainer.axis = .vertical
        hardSkillsContainer.spacing = 8
        hardSkillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        hardSkillsTitleLabel.attributedText = NSAttributedString(
            string: "Hard Skills",
            attributes: TypographyEmphasized.title2
        )
        hardSkillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hardSkillsList.axis = .vertical
        hardSkillsList.spacing = 8
        hardSkillsList.translatesAutoresizingMaskIntoConstraints = false
        
        if let skills = reflection?.skill {
            let hardSkills = skills
                .filter { $0.type == "hardskill" }
                .map { $0.name }
            
            if hardSkills.isEmpty {
                let textLabel = UILabel()
                textLabel.text = "You did not get any hard skills."
                textLabel.textColor = .systemGray2
                hardSkillsList.addArrangedSubview(textLabel)
            } else {
                for skill in hardSkills {
                    let skillView = createSkillView(skillName: skill)
                    hardSkillsList.addArrangedSubview(skillView)
                }
            }
        }
        
        hardSkillsContainer.addArrangedSubview(hardSkillsTitleLabel)
        hardSkillsContainer.addArrangedSubview(hardSkillsList)
        contentView.addArrangedSubview(hardSkillsContainer)
        
        NSLayoutConstraint.activate([
            hardSkillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hardSkillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupSummarySection() {
        summaryContainer.axis = .vertical
        summaryContainer.spacing = 8
        summaryContainer.translatesAutoresizingMaskIntoConstraints = false
        
        summaryTitleLabel.attributedText = NSAttributedString(
            string: "Summary",
            attributes: TypographyEmphasized.title2
        )
        summaryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryBackgroundView.backgroundColor = UIColor(named: "BTint200")?.withAlphaComponent(0.2)
        summaryBackgroundView.layer.cornerRadius = 8
        summaryBackgroundView.layer.borderColor = UIColor(named: "BTint200")?.cgColor
        summaryBackgroundView.layer.borderWidth = 1
        summaryBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        summaryTextLabel.attributedText = NSAttributedString(
            string: reflection?.summary ?? "Summary is Empty",
            attributes: TypographyRegular.body
        )
        summaryTextLabel.numberOfLines = 0
        summaryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryBackgroundView.addSubview(summaryTextLabel)
        summaryContainer.addArrangedSubview(summaryTitleLabel)
        summaryContainer.addArrangedSubview(summaryBackgroundView)
        contentView.addArrangedSubview(summaryContainer)
        
        NSLayoutConstraint.activate([
            summaryContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            summaryBackgroundView.widthAnchor.constraint(equalTo: summaryContainer.widthAnchor),
            
            summaryTextLabel.topAnchor.constraint(equalTo: summaryBackgroundView.topAnchor, constant: 16),
            summaryTextLabel.leadingAnchor.constraint(equalTo: summaryBackgroundView.leadingAnchor, constant: 16),
            summaryTextLabel.trailingAnchor.constraint(equalTo: summaryBackgroundView.trailingAnchor, constant: -16),
            summaryTextLabel.bottomAnchor.constraint(equalTo: summaryBackgroundView.bottomAnchor, constant: -16)
        ])
    }
    
    private func createSkillView(skillName: String) -> UIView {
        let skillView = UIView()
        if let borderColor = UIColor(named: "BTint200")?.cgColor {
            skillView.layer.borderColor = borderColor
        }
        skillView.layer.borderWidth = 1
        skillView.backgroundColor = UIColor(named: "BTint200")?.withAlphaComponent(0.2)
        skillView.layer.cornerRadius = 8
        skillView.translatesAutoresizingMaskIntoConstraints = false
        
        let skillLabel = UILabel()
        skillLabel.attributedText = NSAttributedString(
            string: skillName,
            attributes: TypographyRegular.body
        )
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "checkmark.seal.fill")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: "BTint200")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        skillView.addSubview(iconImageView)
        skillView.addSubview(skillLabel)
        
        NSLayoutConstraint.activate([
            skillView.heightAnchor.constraint(equalToConstant: 52),
            
            iconImageView.centerYAnchor.constraint(equalTo: skillView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: skillView.leadingAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            skillLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
        ])
        
        return skillView
    }
}
