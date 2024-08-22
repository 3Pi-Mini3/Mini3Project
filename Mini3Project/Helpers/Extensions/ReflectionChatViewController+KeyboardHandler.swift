//
//  ReflectionChatViewController+KeyboardHandler.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit

extension ReflectionChatViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func dismissKB() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        adjustViewConstraints(keyboardHeight: keyboardHeight, duration: duration)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        adjustViewConstraints(keyboardHeight: 0, duration: duration)
    }
    
    private func adjustViewConstraints(keyboardHeight: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration) {
            if keyboardHeight == 0 {
                self.bottomViewBottomConstraint.constant = 0
            } else {
                self.bottomViewBottomConstraint.constant = 21 - keyboardHeight
            }
            
            self.view.layoutIfNeeded()
        }
    }
}
