//
//  ConfirmationViewController.swift
//  Mini3Project
//
//  Created by Lucky on 25/08/24.
//

import UIKit

class ConfirmationViewController: UIViewController {

    private let confirmationView = ConfirmationView()
    
    var onContinue: (() -> Void)?
    var onExit: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfirmationView()
        addTapGestureToDismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.1, animations: {
             self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
         })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.backgroundColor = .clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.view.backgroundColor = .clear
    }
}

private extension ConfirmationViewController {
    private func addTapGestureToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutside() {
        let touchLocation = touchLocationInView()
        let isTouchInsideConfirmationView = confirmationView.frame.contains(touchLocation)
        
        if !isTouchInsideConfirmationView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func touchLocationInView() -> CGPoint {
        guard let touch = view.gestureRecognizers?.first?.location(in: view) else {
            return CGPoint.zero
        }
        return touch
    }
}

private extension ConfirmationViewController {
    private func setupConfirmationView() {
        view.addSubview(confirmationView)
        
        NSLayoutConstraint.activate([
            confirmationView.heightAnchor.constraint(equalToConstant: 476),
            confirmationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confirmationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confirmationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        confirmationView.onContinue = {
            self.onContinue?()
            self.dismiss(animated: true, completion: nil)
        }
        
        confirmationView.onExit = {
            self.onExit?()
            
            let tabBarController = CustomTabBarController()
            let navController = UINavigationController(rootViewController: tabBarController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
