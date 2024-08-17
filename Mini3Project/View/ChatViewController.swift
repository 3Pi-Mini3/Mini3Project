//
//  ChatViewController.swift
//  Mini3Project
//
//  Created by Agfi on 16/08/24.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let tableView = UITableView()
    private let inputTextField = UITextField()
    private let sendButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system) // Add reset button
    
    private var messages: [String] = []
    private let aiService = GenerativeAIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // Set up the table view for chat messages
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        // Set up the text input field
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = "Ask me anything..."
        inputTextField.borderStyle = .roundedRect
        inputTextField.delegate = self
        view.addSubview(inputTextField)
        
        // Set up the send button
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        view.addSubview(sendButton)
        
        // Set up the reset button
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(resetChat), for: .touchUpInside)
        view.addSubview(resetButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // TableView constraints
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputTextField.topAnchor, constant: -10),
            
            // InputTextField constraints
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            inputTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // SendButton constraints
            sendButton.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor, constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            
            // ResetButton constraints
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.widthAnchor.constraint(equalToConstant: 60),
            resetButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let message = messages[indexPath.row]
        
        // Style the message cell based on sender (User or AI)
        if message.hasPrefix("User:") {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .blue
        } else if message.hasPrefix("AI:") {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .green
        }
        
        cell.textLabel?.text = message
        cell.textLabel?.numberOfLines = 0 // For multi-line messages
        return cell
    }
    
    // MARK: - Send Message Action
    @objc private func sendMessage() {
        guard let userInput = inputTextField.text, !userInput.isEmpty else { return }
        
        // Append the user input to the messages array
        messages.append("User: \(userInput)")
        tableView.reloadData()
        
        // Clear the input field
        inputTextField.text = ""
        
        // Call the AI service to generate a response
        Task {
            do {
                let response = try await aiService.generateResponse(for: userInput)
                messages.append("AI: \(response)")
                tableView.reloadData()
                
                // Scroll to the bottom to show the latest message
                if messages.count > 0 {
                    let indexPath = IndexPath(row: messages.count - 1, section: 0)
                    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            } catch {
                messages.append("Error: \(error.localizedDescription)")
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Reset Chat Action
    @objc private func resetChat() {
        messages.removeAll() // Clear messages in the UI
        aiService.resetConversation() // Reset the conversation history in the AI service
        tableView.reloadData()
    }
}
