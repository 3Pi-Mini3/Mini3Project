import UIKit

class EmptyStateView: UIView {
    private let imageName: String
    private let desc: String
    
    private lazy var emptyStateImageView: UIImageView = UIImageView()
    private lazy var emptyStateLabel: UILabel = UILabel()
    
    init(imageName: String, desc: String) {
        self.imageName = imageName
        self.desc = desc
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        emptyStateImageView.image = UIImage(named: imageName)
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyStateLabel.text = desc
        emptyStateLabel.textColor = .systemGray2
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emptyStateImageView)
        addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 120),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 150),
            emptyStateImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateImageView.bottomAnchor),
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
