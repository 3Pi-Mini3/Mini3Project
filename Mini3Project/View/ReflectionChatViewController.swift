//
//  ReflectionChatViewController.swift
//  Mini3Project
//
//  Created by Lucky on 20/08/24.
//

import UIKit

class ReflectionChatViewController: UIViewController {
    
    var viewModel = ReflectionChatViewModel()
    
    var topic: String?
    
    var bottomViewBottomConstraint: NSLayoutConstraint!
    private var confirmationViewBottomConstraint: NSLayoutConstraint?
    
    private lazy var topView: UIView = createTopView()
    private lazy var chatScrollView: UIScrollView = createChatScrollView()
    private lazy var chatView: UIView = createChatView()
    private lazy var bottomView: UIView = createBottomView()
    private lazy var textView: UITextView = createTextView()
    private lazy var sendButton: UIButton = createSendButton()
    private lazy var nextButton: UIButton = createNextButton()
    private lazy var backButton: UIButton = createBackButton()
    
    
    lazy var mascotImageView: MascotImageView = createMascotImageView()
    lazy var progressBarView: ProgressBarView = createProgressBarView()
    lazy var confirmationView: ConfirmationView = createConfirmationBarView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        
        viewModel.topic = self.topic!
        
        setupReflectionChatView()
        
        setupKeyboardObservers()
        setButtonHandling()
        dismissKB()
        
        startProgressLabel()
        loadCurrentPhase()
    }
}

// MARK: Load Bubble Chat
private extension ReflectionChatViewController {
    private func loadCurrentPhase() {
        viewModel.hasShownInitialMessage = false
        loadAllQuestions(at: viewModel.currentQuestionIndex)
    }

    private func loadAllQuestions(at index: Int) {
        if !viewModel.hasShownInitialMessage {
            loadFirstQuestion(at: index)
        } else {
            loadQuestions(at: index)
        }
    }
    
    private func loadQuestions(at index: Int) {
        let typingIndicator = "..."
        sendButton.isEnabled = false
        addChatBubble(isLeft: true, text: typingIndicator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            self.removeLastChatBubble()
            
            if let question = self.viewModel.getCurrentQuestion() {
                self.addChatBubble(isLeft: true, text: question)
                self.viewModel.updateReflections(with: "Question: \(question)\n")
                self.sendButton.isEnabled = true
                self.updateProgressBar()
            }
        }
    }

    private func loadFirstQuestion(at index: Int) {
        let typingIndicator = "..."
        sendButton.isEnabled = false
        addChatBubble(isLeft: true, text: typingIndicator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.removeLastChatBubble()
            
            if let initialMessage = self.viewModel.getInitialMessage() { 
                self.addChatBubble(isLeft: true, text: initialMessage)
                self.viewModel.hasShownInitialMessage = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    guard let self = self else { return }
                    
                    self.addChatBubble(isLeft: true, text: typingIndicator)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                        guard let self = self else { return }
                        
                        self.removeLastChatBubble()
                        
                        if let question = self.viewModel.getCurrentQuestion() {
                            self.addChatBubble(isLeft: true, text: question)
                            self.viewModel.updateReflections(with: "Question: \(question)\n")
                            self.sendButton.isEnabled = true
                            self.updateProgressBar()
                        }
                    }
                }
            }
        }
    }
    
    private func addChatBubble(isLeft: Bool, text: String) {
        let chatBubbleView = ChatBubbleView(isLeft: isLeft, text: text)
        
        chatView.addSubview(chatBubbleView)
        
        let previousBubble = chatView.subviews.dropLast().last

        NSLayoutConstraint.activate([
            chatBubbleView.widthAnchor.constraint(lessThanOrEqualTo: chatView.widthAnchor, multiplier: 0.87),
            chatBubbleView.topAnchor.constraint(equalTo: previousBubble?.bottomAnchor ?? chatView.topAnchor, constant: 16),
            isLeft ? chatBubbleView.leadingAnchor.constraint(equalTo: chatView.leadingAnchor) : chatBubbleView.trailingAnchor.constraint(equalTo: chatView.trailingAnchor)
        ])
        
        if let previousBottomConstraint = chatView.constraints.first(where: { $0.firstAttribute == .bottom }) {
            previousBottomConstraint.isActive = false
            chatView.removeConstraint(previousBottomConstraint)
        }

        let bottomConstraint = chatBubbleView.bottomAnchor.constraint(equalTo: chatView.bottomAnchor, constant: -12)
        bottomConstraint.isActive = true 
        
        self.chatView.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.scrollToBottom()
        }
    }
    
    private func removeLastChatBubble() {
        guard let lastBubble = chatView.subviews.last else { return }
        lastBubble.removeFromSuperview()
    }
    
    private func scrollToBottom(animated: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let bottomOffset = CGPoint(x: 0, y: (self.chatScrollView.contentSize.height) - self.chatScrollView.bounds.height)
            if bottomOffset.y > 0 {
                self.chatScrollView.setContentOffset(bottomOffset, animated: animated)
            }
        }
    }
}

extension ReflectionChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.size.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let maxTextViewHeight: CGFloat = 100

        let textViewHeight = min(estimatedSize.height, maxTextViewHeight)
        
        guard textView.contentSize.height < 100.0 else { textView.isScrollEnabled = true; return }
        
        textView.isScrollEnabled = false
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = textViewHeight
            }
        }
        
        bottomView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = textViewHeight + 29 + 10
            }
        }
    }
}

// MARK: Set Button Handling
private extension ReflectionChatViewController {
    private func setButtonHandling() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPhaseButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}

// MARK: Button Handling
private extension ReflectionChatViewController {
    @objc private func backButtonTapped() {
        self.view.endEditing(true)
        
        showConfirmationView()
    }
    
    @objc private func sendButtonTapped() {
        guard let text = textView.text, !text.isEmpty else { return }
        addChatBubble(isLeft: false, text: text)
        viewModel.updateReflections(with: "Answer: \(text)\n\n")
        textView.text = ""
        resetInputViewConstraints()
        viewModel.moveToNextQuestion()
        
        if viewModel.currentQuestionIndex < viewModel.questions[viewModel.currentPhaseIndex].count {
            loadAllQuestions(at: viewModel.currentQuestionIndex)
        } else {
            viewModel.moveToNextPhase()
            if viewModel.currentPhaseIndex < viewModel.questions.count {
                showNextPhaseButton()
            } else {
                self.view.endEditing(true)
                
                viewModel.generateSummaryAndSave()
                
                let vc = BridgeNextViewController()
                
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen

                present(navController, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func nextPhaseButtonTapped() {
        let vc = BridgeGateViewController()
        
        vc.updateContent(
            imageName: BridgeGate.imageNames[viewModel.currentPhaseIndex - 1], 
            titleText: BridgeGate.titles[viewModel.currentPhaseIndex - 1], 
            subTitleText: BridgeGate.descriptions[viewModel.currentPhaseIndex - 1]
        )
        
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen

        present(navController, animated: true, completion: nil)
        
        chatView.subviews.forEach { $0.removeFromSuperview() }
        
        resetInputViewConstraints()
        restoreInputViewAppearance()
        
        startProgressLabel()
        
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.loadCurrentPhase()
        }
    }
}

// MARK: Show View
private extension ReflectionChatViewController {    
    private func showNextPhaseButton() {
        self.view.endEditing(true)
        nextButton.isHidden = false
        textView.isHidden = true
        sendButton.isHidden = true
        
        bottomView.backgroundColor = .clear
        
        bottomView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 361),
            nextButton.heightAnchor.constraint(equalToConstant: 46),
            
            nextButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
    }

    private func showConfirmationView() {
        view.addSubview(confirmationView)
        
        NSLayoutConstraint.activate([
            confirmationView.heightAnchor.constraint(equalToConstant: 476),
            
            confirmationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            confirmationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            confirmationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Configure the confirmation view
        confirmationView.onContinue = {
            self.confirmationView.dismissAlert()
        }
        confirmationView.onExit = {
            self.confirmationView.dismissAlert()
            
            let vc = CustomTabBarController()
            
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen

            self.present(navController, animated: true, completion: nil)
        }
        
        confirmationView.presentAlert(in: self)
    }
}

// MARK: Reset View
private extension ReflectionChatViewController {
    private func restoreInputViewAppearance() {
        bottomView.backgroundColor = UIColor(named: "CardBG")
        textView.backgroundColor = UIColor(named: "AlertBG")
        
        textView.isHidden = false
        sendButton.isHidden = false
        
        nextButton.isHidden = true
    }
    
    private func resetInputViewConstraints() {
        if let textViewHeightConstraint = textView.constraints.first(where: { $0.firstAttribute == .height }) {
            textViewHeightConstraint.constant = 46.0
        }
        
        if let bottomViewHeightConstraint = bottomView.constraints.first(where: { $0.firstAttribute == .height }) {
            bottomViewHeightConstraint.constant = 87.0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Setup View
private extension ReflectionChatViewController {
    private func setupReflectionChatView() {
        self.navigationItem.hidesBackButton = true 
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(mascotImageView)
        
        NSLayoutConstraint.activate([
            mascotImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mascotImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mascotImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        mascotImageView.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: 44),
            
            topView.topAnchor.constraint(equalTo: mascotImageView.topAnchor, constant: 53),
            topView.leadingAnchor.constraint(equalTo: mascotImageView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: mascotImageView.trailingAnchor)
        ])
        
        topView.addSubview(progressBarView)
        
        NSLayoutConstraint.activate([
            progressBarView.topAnchor.constraint(equalTo: topView.topAnchor),
            progressBarView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            progressBarView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 36),
            progressBarView.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
        
        topView.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 23), // Set width
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            backButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 11),
            backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
        ])
        
        self.view.addSubview(chatScrollView)
        
        NSLayoutConstraint.activate([
            chatScrollView.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor),
            chatScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            chatScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
        
        chatScrollView.addSubview(chatView)
        
        NSLayoutConstraint.activate([
            chatView.widthAnchor.constraint(equalTo: chatScrollView.widthAnchor),
            
            chatView.topAnchor.constraint(equalTo: chatScrollView.topAnchor),
            chatView.leadingAnchor.constraint(equalTo: chatScrollView.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: chatScrollView.trailingAnchor),
            chatView.bottomAnchor.constraint(equalTo: chatScrollView.bottomAnchor)
        ])
        
        self.view.addSubview(bottomView)
        bottomView.heightAnchor.constraint(equalToConstant: 87.0).isActive = true
        bottomViewBottomConstraint = bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        bottomViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // Note: Add chatScrollView bottom anchor
            chatScrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        bottomView.addSubview(textView)
        textView.heightAnchor.constraint(equalToConstant: 46.0).isActive = true
        
        NSLayoutConstraint.activate([
            textView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -29),
            textView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -57),
        ])
        
        bottomView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 32),
            sendButton.heightAnchor.constraint(equalToConstant: 32),
            
            sendButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -36),
            sendButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
        ])
    }
}
