import UIKit

class ReflectionDetailViewController: UIViewController {
    var reflection: Reflection?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the view
        view.backgroundColor = .systemBackground
        title = reflection?.topic
        navigationController?.navigationBar.prefersLargeTitles = true

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

}
