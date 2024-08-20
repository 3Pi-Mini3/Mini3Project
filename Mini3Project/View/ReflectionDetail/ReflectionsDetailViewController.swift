import UIKit

class ReflectionDetailViewController: UIViewController {
    var reflection: Reflection?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000) // Set a large enough value or dynamically calculate based on content
        ])
    }
    
    private func setupSoftSkillsSection() {
        softSkillsContainer.axis = .vertical
        softSkillsContainer.spacing = 8
        softSkillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        softSkillsTitleLabel.attributedText = NSAttributedString(
            string: "Soft Skills",
            attributes: TypographyRegular.headline
        )
        softSkillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        softSkillsList.axis = .vertical
        softSkillsList.spacing = 8
        softSkillsList.translatesAutoresizingMaskIntoConstraints = false
        
        if let skills = reflection?.skill {
            let softSkills = skills
                .filter { $0.type == "softskill" }
                .map { $0.name }
            
            for skill in softSkills {
                let skillView = createSkillView(skillName: skill, borderColorName: "YellowButton")
                softSkillsList.addArrangedSubview(skillView)
            }
        }
        
        softSkillsContainer.addArrangedSubview(softSkillsTitleLabel)
        softSkillsContainer.addArrangedSubview(softSkillsList)
        contentView.addSubview(softSkillsContainer)
        
        NSLayoutConstraint.activate([
            softSkillsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            softSkillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            softSkillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupHardSkillsSection() {
        hardSkillsContainer.axis = .vertical
        hardSkillsContainer.spacing = 8
        hardSkillsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        hardSkillsTitleLabel.attributedText = NSAttributedString(
            string: "Hard Skills",
            attributes: TypographyRegular.headline
        )
        hardSkillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hardSkillsList.axis = .vertical
        hardSkillsList.spacing = 8
        hardSkillsList.translatesAutoresizingMaskIntoConstraints = false
        
        if let skills = reflection?.skill {
            let hardSkills = skills
                .filter { $0.type == "hardskill" }
                .map { $0.name }
            
            for skill in hardSkills {
                let skillView = createSkillView(skillName: skill, borderColorName: "BTint200")
                hardSkillsList.addArrangedSubview(skillView)
            }
        }
        
        hardSkillsContainer.addArrangedSubview(hardSkillsTitleLabel)
        hardSkillsContainer.addArrangedSubview(hardSkillsList)
        contentView.addSubview(hardSkillsContainer)
        
        NSLayoutConstraint.activate([
            hardSkillsContainer.topAnchor.constraint(equalTo: softSkillsContainer.bottomAnchor, constant: 24),
            hardSkillsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hardSkillsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupSummarySection() {
        summaryContainer.axis = .vertical
        summaryContainer.spacing = 8
        summaryContainer.translatesAutoresizingMaskIntoConstraints = false
        
        summaryTitleLabel.attributedText = NSAttributedString(
            string: "Summary",
            attributes: TypographyRegular.headline
        )
        summaryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryBackgroundView.backgroundColor = UIColor(named: "Info")?.withAlphaComponent(0.2)
        summaryBackgroundView.layer.cornerRadius = 8
        summaryBackgroundView.layer.borderColor = UIColor(named: "Info")?.cgColor
        summaryBackgroundView.layer.borderWidth = 1
        summaryBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        summaryTextLabel.attributedText = NSAttributedString(
            string: "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Blanditiis deserunt similique iure perspiciatis quis obcaecati nam? Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis? Lorem ipsum dolor sit, amet consectetur adipisicing elit. Blanditiis deserunt similique iure perspiciatis quis obcaecati nam? Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis? Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis? Lorem ipsum dolor sit, amet consectetur adipisicing elit. Blanditiis deserunt similique iure perspiciatis quis obcaecati nam? Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis?Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis? Lorem ipsum dolor sit, amet consectetur adipisicing elit. Blanditiis deserunt similique iure perspiciatis quis obcaecati nam? Tenetur vel dolore, optio qui harum laudantium id omnis officiis commodi corporis quas quis?",
            attributes: TypographyRegular.body
        )
        summaryTextLabel.numberOfLines = 0
        summaryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryBackgroundView.addSubview(summaryTextLabel)
        summaryContainer.addArrangedSubview(summaryTitleLabel)
        summaryContainer.addArrangedSubview(summaryBackgroundView)
        contentView.addSubview(summaryContainer)
        
        NSLayoutConstraint.activate([
            summaryContainer.topAnchor.constraint(equalTo: hardSkillsContainer.bottomAnchor, constant: 24),
            summaryContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            summaryContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            summaryBackgroundView.widthAnchor.constraint(equalTo: summaryContainer.widthAnchor),
            
            summaryTextLabel.topAnchor.constraint(equalTo: summaryBackgroundView.topAnchor, constant: 16),
            summaryTextLabel.leadingAnchor.constraint(equalTo: summaryBackgroundView.leadingAnchor, constant: 16),
            summaryTextLabel.trailingAnchor.constraint(equalTo: summaryBackgroundView.trailingAnchor, constant: -16),
            summaryTextLabel.bottomAnchor.constraint(equalTo: summaryBackgroundView.bottomAnchor, constant: -16)
        ])
    }
    
    private func createSkillView(skillName: String, borderColorName: String) -> UIView {
        let skillView = UIView()
        if let borderColor = UIColor(named: borderColorName)?.cgColor {
            skillView.layer.borderColor = borderColor
        }
        skillView.layer.borderWidth = 1
        skillView.backgroundColor = UIColor(named: borderColorName)?.withAlphaComponent(0.2)
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
        iconImageView.tintColor = UIColor(named: borderColorName)
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
