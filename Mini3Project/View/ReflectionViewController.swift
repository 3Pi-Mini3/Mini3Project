//
//  ReflectionViewController.swift
//  Mini3Project
//
//  Created by Agfi on 19/08/24.
//

import UIKit

class ReflectionViewController: UIViewController {
    
    // Reference to the ViewModel
    private var viewModel: ReflectionViewModel

    // UI Elements
    private let topicTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter topic"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let answersTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Initializer
    init(viewModel: ReflectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UI
        setupUI()
        
        // Bind UI to ViewModel
        bindViewModel()
        
        // Add target for the save button
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(topicTextField)
        view.addSubview(answersTextView)
        view.addSubview(saveButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            topicTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topicTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topicTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answersTextView.topAnchor.constraint(equalTo: topicTextField.bottomAnchor, constant: 20),
            answersTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answersTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answersTextView.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.topAnchor.constraint(equalTo: answersTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindViewModel() {
        // Bind the ViewModel to the UI elements
        topicTextField.text = viewModel.topic
        answersTextView.text = viewModel.answers.joined(separator: "\n")
    }
    
    @objc private func saveButtonTapped() {
        // Save data from UI to the ViewModel
        viewModel.updateTopic(newTopic: topicTextField.text ?? "")
        viewModel.answers = answersTextView.text.components(separatedBy: "\n")
        
        // Optionally, convert ViewModel back to model and save or process further
        let reflectionModel = viewModel.toReflectionModel()
        print("Saved Reflection Model: \(reflectionModel)")
        
        // Here you would typically save to a database or perform further actions
    }
}
