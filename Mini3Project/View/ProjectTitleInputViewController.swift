//
//  ProjectTitleInputViewController.swift
//  Mini3Project
//
//  Created by Lucky on 18/08/24.
//

import UIKit

class ProjectTitleInputViewController: UIViewController {
    private var nextButtonBottomConstraint: NSLayoutConstraint?
    
    private lazy var titleView: UIView = createTitleView()
    private lazy var textFieldView: UIView = createTextFieldView()
    private lazy var textField: UITextField = createTextField()
    private lazy var titleLabel: UILabel = createTitleLabel()
    private lazy var nextButton: UIButton = createNextButton()
    
    
    lazy var mascotImageView: MascotImageView = createMascotImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        setupProjectTitleInputView()
        
        setupKeyboardObservers()
        
        dismissKB()
        
        customizeBackButtonAppearance()
    }
}

private extension ProjectTitleInputViewController {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func nextButtonTapped() {
        let topic = textField.text
        
        let vc = ReflectionChatViewController()
        vc.topic = topic
        
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen

        present(navController, animated: false, completion: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        nextButtonBottomConstraint?.constant = -keyboardHeight - 16
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        nextButtonBottomConstraint?.constant = -16
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

private extension ProjectTitleInputViewController {
    private func customizeBackButtonAppearance() {
        let backButton = UIBarButtonItem()
        backButton.title = "Skills"
        backButton.tintColor = UIColor(named: "BTint200")
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func dismissKB() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
}

extension ProjectTitleInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldView.layer.borderColor = UIColor(named: "Bluemarine")?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldView.layer.borderColor = UIColor(named: "LineStroke")?.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
                
        if !string.isEmpty {
            textField.textColor = UIColor(named: "Text")
        } else {
            textField.textColor = UIColor(named: "Lightgray")
        }
        
        updateNextButtonState(isTextEmpty: newText?.isEmpty ?? true)
        
        return true
    }
    
    private func updateNextButtonState(isTextEmpty: Bool = true) {
        let backgroundColor: UIColor = isTextEmpty ? UIColor(named: "BTint200")! : UIColor(named: "Bluemarine")!
        let titleColor: UIColor = isTextEmpty ? UIColor(named: "BTint300")! : UIColor(named: "BTint300")!
        
        nextButton.backgroundColor = backgroundColor
        
        let attributedTitle = NSAttributedString(
            string: "Next",
            attributes: [
                .foregroundColor: titleColor,
                .font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ]
        )
        nextButton.setAttributedTitle(attributedTitle, for: .normal)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        nextButton.isEnabled = !isTextEmpty
    }
}

private extension ProjectTitleInputViewController {
    
    private func setupProjectTitleInputView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: 52),
            
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        titleView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 41),
            
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -16)
        ])
        
        self.view.addSubview(mascotImageView)
        
        NSLayoutConstraint.activate([
            mascotImageView.widthAnchor.constraint(equalToConstant: 188),
            mascotImageView.heightAnchor.constraint(equalToConstant: 135),
            
            mascotImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mascotImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.view.addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            textFieldView.heightAnchor.constraint(equalToConstant: 46),
            
            textFieldView.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor, constant: 16),
            textFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        
        textFieldView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 12),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -12),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -12)
        ])
        
        textFieldView.bringSubviewToFront(textField)
        
        self.view.addSubview(nextButton)
        
        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        nextButtonBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
