//
//  ProgressBarView.swift
//  Mini3Project
//
//  Created by Lucky on 22/08/24.
//

import UIKit

class ProgressBarView: UIView {
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = UIColor(named: "Bluemarine")
        progressView.trackTintColor = UIColor(named: "LineStroke")
        progressView.setProgress(0, animated: true) // Initial progress
        
        // Set corner radius
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        
        // Apply corner radius to the track and progress sublayers
        progressView.layer.sublayers?.forEach { $0.cornerRadius = 10 }
        progressView.subviews.forEach { $0.clipsToBounds = true }
        
        // Shadow
        progressView.layer.shadowColor = UIColor(named: "LineStroke")?.cgColor
        progressView.layer.shadowOffset = CGSize(width: 0, height: -4)
        progressView.layer.shadowOpacity = 0.5
        progressView.layer.shadowRadius = 4
        progressView.layer.masksToBounds = false
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "- of -"
        label.textColor = .white
        label.textAlignment = .center
        
        let attributedText = NSAttributedString(
            string: label.text ?? "",
            attributes: TypographyEmphasized.body
        )
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false 
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProgressBarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgressBar(_ progress: Float) {
        progressBar.setProgress(progress, animated: true)
    }
    
    func updateProgressLabel(text: String) {
        progressLabel.text = text
    }
}

private extension ProgressBarView {
    
    private func setupProgressBarView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            
            progressBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        progressBar.addSubview(progressLabel)
        
        NSLayoutConstraint.activate([
            progressLabel.heightAnchor.constraint(equalToConstant: 22),
            
            progressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            progressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            progressLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
        ])
        
    }
    
}
