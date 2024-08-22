import UIKit

class SkillView: UIView {
    private let skillName: String
    
    private let skillLabel = UILabel()
    private let iconImageView = UIImageView()
    
    init(skillName: String) {
        self.skillName = skillName
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        if let borderColor = UIColor(named: "BTint200")?.cgColor {
            layer.borderColor = borderColor
        }
        layer.borderWidth = 1
        backgroundColor = UIColor(named: "BTint200")?.withAlphaComponent(0.2)
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        skillLabel.attributedText = NSAttributedString(
            string: skillName,
            attributes: TypographyRegular.body
        )
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.image = UIImage(systemName: "checkmark.seal.fill")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: "BTint200")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        addSubview(skillLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),
            
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            skillLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
        ])
    }
}
