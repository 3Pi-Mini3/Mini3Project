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
            showAlert(title: "Input Error", message: "Please fill in the topic and all answers.")
            return
        }
        
        let answers = [answer1, answer2, answer3, answer4]
        
        Task {
            do {
                let answersText = answers.joined(separator: "\n")
                print("Answer Text \(answersText)")
                
                let summary = try await aiService.generateOneResponse(for: "Only me a summary in one paragraph with list of hardskill and softskill that I learned from this reflection: \(answersText)")
                
                let rawHardSkills = try await aiService.generateOneResponse(for: "Please list only the technical or design-related skills mentioned in this reflection. Do not include any soft skills or personal qualities. Provide the list as plain text without bullet points or extra descriptions: \(answersText)")
                
                let separatedHardSkills = rawHardSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
                print("Separated Hard Skills: \(separatedHardSkills)")
                
                let diagnoseRoleSkills = try await aiService.generateOneResponse(for: "\(separatedHardSkills) just declare the type of skills from above skills without any description, is it coding, design, or product with template [Skills:Type of skill]")
                print("Diagnose Raw Role Skills: \n \(diagnoseRoleSkills)")
                
                let rawSoftSkills = try await aiService.generateOneResponse(for: "Please list only the soft skills or personal qualities mentioned in this reflection. Do not include any technical or design-related skills. Provide the list as plain text without bullet points or extra descriptions: \(answersText)")
                print("Softskills: \n \(rawSoftSkills)")
                
                let separatedSoftSkills = rawSoftSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
                
                let skillsWithRoles = parseSkillsWithRoles(from: diagnoseRoleSkills)
                
                print(skillsWithRoles)
                
                viewModel.createReflection(topic: topic, answers: answers, hardSkillsWithRoles: skillsWithRoles, softSkills: separatedSoftSkills, summary: summary)
                
                showAlert(title: "Success", message: "Reflection saved with summary: \(summary)")
                
            } catch {
                showAlert(title: "Error", message: "Failed to generate summary: \(error.localizedDescription)")
            }
        }
    }


    private func parseSkillsWithRoles(from response: String) -> [(skill: String, role: String)] {
        var skillsWithRoles: [(skill: String, role: String)] = []
        
        // Remove the "Skills:" prefix if it exists
        var cleanedResponse = response.replacingOccurrences(of: "Skills:\n", with: "")
        
        // Remove the bullet points and trim whitespace
        cleanedResponse = cleanedResponse.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Split the response into lines
        let lines = cleanedResponse.components(separatedBy: "\n")
        
        for line in lines {
            // Split each line by the colon to separate skill and role
            let components = line.components(separatedBy: ":")
            if components.count == 2 {
                let skill = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let role = components[1].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                skillsWithRoles.append((skill: skill, role: role))
            }
        }
        
        return skillsWithRoles
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
