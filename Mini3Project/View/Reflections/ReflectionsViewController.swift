import UIKit
import Combine
import SwiftData

enum Section {
    case reflections
}

class ReflectionsViewController: UIViewController {
    // MARK: - UI Elements
    private let reflectionButton: UIButton = UIButton()
    private let dateLabel: UILabel = UILabel()
    
    var viewModel: ReflectionsViewModel = ReflectionsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    var container: ModelContainer?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Reflection>?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = try? ModelContainer(for: Reflection.self)
        createCollectionView()
        createDataSource()
        loadReflections()
        
        generateData()
        
        configureView()
        configureReflectionButton()
        configureDateLabel()
        bindViewModel()
    }
    
    func generateData() {
        let reflection1 = Reflection(topic: "topic 1", answers: ["ans1", "ans2"], createdAt: Date())
        let reflection2 = Reflection(topic: "topic 2", answers: ["ans1", "ans2"], createdAt: Date())
        let reflection3 = Reflection(topic: "topic 3", answers: ["ans1", "ans2"], createdAt: Date())

        
        container?.mainContext.insert(reflection1)
        container?.mainContext.insert(reflection2)
        container?.mainContext.insert(reflection3)
        
        loadReflections()
    }
    
    func createCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "Reflection")
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Reflection>(collectionView: collectionView) { collectionView, indexPath, reflection in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reflection", for: indexPath)
            
            var content = UIListContentConfiguration.cell()
            content.text = "Relfection topic: \(reflection.topic)."
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
    func loadReflections() {
        let descriptor = FetchDescriptor<Reflection>()
        let reflections = (try? container?.mainContext.fetch(descriptor)) ?? []
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Reflection>()
        snapshot.appendSections([.reflections])
        snapshot.appendItems(reflections)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - View Configuration
    private func configureView() {
        view.backgroundColor = .white
        title = "Reflections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureReflectionButton() {
        reflectionButton.configuration = .filled()
        reflectionButton.configuration?.baseBackgroundColor = .systemBlue
        reflectionButton.configuration?.title = "Reflection"
        
        reflectionButton.addTarget(self, action: #selector(goToReflectionDetail), for: .touchUpInside)
        
        view.addSubview(reflectionButton)
        reflectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reflectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reflectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            reflectionButton.widthAnchor.constraint(equalToConstant: 200),
            reflectionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureDateLabel() {
        dateLabel.text = getCurrentDateFormatted()
        dateLabel.layer.cornerRadius = 8
        dateLabel.backgroundColor = .systemGray5
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        dateLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        dateLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 240),
            dateLabel.heightAnchor.constraint(equalToConstant: 48),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    // MARK: - Helpers
    private func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: viewModel.currentDate)
    }
    
    // MARK: - Actions
    @objc private func goToReflectionDetail() {
        let detailViewController = ReflectionDetailViewController()
        detailViewController.title = "Reflection Detail"
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc private func openDatePicker() {
        let datePickerViewController = ReflectionsDatePickerViewController()
        datePickerViewController.modalPresentationStyle = .popover
        datePickerViewController.preferredContentSize = CGSize(width: 320, height: 248)
        datePickerViewController.viewModel = viewModel
        
        if let popover = datePickerViewController.popoverPresentationController {
            popover.sourceView = dateLabel
            popover.sourceRect = dateLabel.bounds
            popover.permittedArrowDirections = .up
            popover.delegate = self
        }
        
        present(datePickerViewController, animated: true, completion: nil)
    }
    
    private func bindViewModel() {
        viewModel.$currentDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newDate in
                self?.dateLabel.text = self?.getCurrentDateFormatted()
            }
            .store(in: &cancellables)
    }
    
    
}


// MARK: - UIPopoverPresentationControllerDelegate
extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
