import UIKit

class ReflectionCardView: UIView {
    private let reflection: Reflection
    
    private lazy var reflectionTopicLabel = UILabel()
    private lazy var reflectionSoftSkillsLabel = UILabel()
    private lazy var reflectionHardSkillsLabel = UILabel()
    private lazy var horizontalLineView: UIView = UIView()
    private lazy var reflectionDateLabel: UILabel = UILabel()
    private lazy var reflectionDetailStack: UIStackView = UIStackView()
    
    init(reflection: Reflection) {
        self.reflection = reflection
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        reflectionTopicLabel.attributedText = NSAttributedString(
            string: reflection.topic,
            attributes: TypographyRegular.headline
        )
        reflectionTopicLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let softSkillsText: String
        let softSkills = Utilities.getReflectionSkillsName(reflection: reflection, skillType: "softskill")
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
        
        let hardSkillsText: String
        let hardSkills = Utilities.getReflectionSkillsName(reflection: reflection, skillType: "hardskill")
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
        
        horizontalLineView.backgroundColor = .separator
        horizontalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        reflectionDateLabel.attributedText = NSAttributedString(
            string: Utilities.getDateFormatted(date: reflection.createdAt, format: "dd MMMM yyyy"),
            attributes: TypographyRegular.caption1
        )
        reflectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(named: "FilledCardPurp")
        layer.cornerRadius = 20
        if let borderColor = UIColor(named: "BTint100")?.cgColor {
            layer.borderColor = borderColor
        }
        layer.borderWidth = 2
        if let shadowColor = UIColor(named: "BTint100")?.cgColor {
            layer.shadowColor = shadowColor
            layer.shadowOpacity = 1.0
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 0
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        reflectionDetailStack = UIStackView(arrangedSubviews: [reflectionTopicLabel, reflectionSoftSkillsLabel, reflectionHardSkillsLabel, horizontalLineView, reflectionDateLabel])
        reflectionDetailStack.axis = .vertical
        reflectionDetailStack.spacing = 16
        reflectionDetailStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(reflectionDetailStack)
        
        NSLayoutConstraint.activate([
            reflectionDetailStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            reflectionDetailStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reflectionDetailStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reflectionDetailStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            horizontalLineView.heightAnchor.constraint(equalToConstant: 1),
            horizontalLineView.leadingAnchor.constraint(equalTo: reflectionDetailStack.leadingAnchor),
            horizontalLineView.trailingAnchor.constraint(equalTo: reflectionDetailStack.trailingAnchor),
        ])
    }
}
