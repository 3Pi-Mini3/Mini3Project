import UIKit

class ReflectionDetailViewController: UIViewController {
    var reflection: Reflection?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

        // Add a label
        let label = UILabel()
        label.text = "Reflection Detail"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // Center the label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        title = reflection?.topic
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureQuestionView() {
        
    }
}
