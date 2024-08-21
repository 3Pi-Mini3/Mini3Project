//
//  ViewController.swift
//  Mini3Project
//
//  Created by Lucky on 14/08/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let topicTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Topic"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let answerTextField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Answer 1"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let answerTextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Answer 2"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let answerTextField3: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Answer 3"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let answerTextField4: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Answer 4"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate Summary & Save", for: .normal)
        return button
    }()
    
    private let viewModel = ReflectionsViewModel()
    private let aiService = GenerativeAIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Add target to the button here where 'self' is available
        generateButton.addTarget(self, action: #selector(generateSummaryAndSave), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(topicTextField)
        view.addSubview(answerTextField1)
        view.addSubview(answerTextField2)
        view.addSubview(answerTextField3)
        view.addSubview(answerTextField4)
        view.addSubview(generateButton)
        
        // Layout constraints
        topicTextField.translatesAutoresizingMaskIntoConstraints = false
        answerTextField1.translatesAutoresizingMaskIntoConstraints = false
        answerTextField2.translatesAutoresizingMaskIntoConstraints = false
        answerTextField3.translatesAutoresizingMaskIntoConstraints = false
        answerTextField4.translatesAutoresizingMaskIntoConstraints = false
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topicTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topicTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topicTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answerTextField1.topAnchor.constraint(equalTo: topicTextField.bottomAnchor, constant: 20),
            answerTextField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerTextField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answerTextField2.topAnchor.constraint(equalTo: answerTextField1.bottomAnchor, constant: 20),
            answerTextField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerTextField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answerTextField3.topAnchor.constraint(equalTo: answerTextField2.bottomAnchor, constant: 20),
            answerTextField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerTextField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answerTextField4.topAnchor.constraint(equalTo: answerTextField3.bottomAnchor, constant: 20),
            answerTextField4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerTextField4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            generateButton.topAnchor.constraint(equalTo: answerTextField4.bottomAnchor, constant: 20),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func generateSummaryAndSave() {
        guard let topic = topicTextField.text, !topic.isEmpty,
              let answer1 = answerTextField1.text, !answer1.isEmpty,
              let answer2 = answerTextField2.text, !answer2.isEmpty,
              let answer3 = answerTextField3.text, !answer3.isEmpty,
              let answer4 = answerTextField4.text, !answer4.isEmpty else {
            // Handle empty input
            showAlert(title: "Input Error", message: "Please fill in the topic and all answers.")
            return
        }
        
        let answers = [answer1, answer2, answer3, answer4]
        
        Task {
            do {
                let answersText = answers.joined(separator: "\n")
                print("Answer Text \(answersText)")
                
                let summary = try await aiService.generateOneResponse(for: "Only me a summary in one paragraph with list of hardskill and softskill that I learned from this reflection: \(answersText)")
                
                let rawHardSkills = try await aiService.generateOneResponse(for: "\(answersText) \n Only show response a list of hard skills without soft skills and only text without bulleted list from above reflection without any description from the list of skill")
                // Example skills generation (this could be improved by the AI as well)
                let separatedHardSkills = rawHardSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }


                let rawSoftSkills = try await aiService.generateOneResponse(for: "\(answersText) Only show response a list of soft skills without hard skills and only text without bulleted list from above reflection without any description from the list of skill")
                print(rawSoftSkills)
                
                let separatedSoftSkills = rawSoftSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
                print(rawSoftSkills)
                print(separatedHardSkills)
                print(separatedSoftSkills)
                
                viewModel.createReflection(topic: topic, answers: answers, hardSkills: separatedHardSkills, softSkills: separatedSoftSkills, summary: summary)
                
                showAlert(title: "Success", message: "Reflection saved with summary: \(summary)")
                
            } catch {
                showAlert(title: "Error", message: "Failed to generate summary: \(error.localizedDescription)")
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
