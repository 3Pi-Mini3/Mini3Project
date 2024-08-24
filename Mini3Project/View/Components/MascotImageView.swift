//
//  MascotImageView.swift
//  Mini3Project
//
//  Created by Lucky on 22/08/24.
//

import UIKit

class MascotImageView: UIView {
    private let backgroundImageView: UIImageView
    
    // Initializer with image name parameter
    init(imageName: String, frame: CGRect = .zero) {
        // Initialize the UIImageView with the image
        let image = UIImage(named: imageName)
        self.backgroundImageView = UIImageView(image: image)
        
        super.init(frame: frame)
        
        setupBackgroundImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to set a new image
    func setBackgroundImage(image: UIImage?) {
        backgroundImageView.image = image
    }
    
    // Method to configure image view properties
    func configure(contentMode: UIView.ContentMode = .scaleAspectFit, cornerRadius: CGFloat = 0) {
        backgroundImageView.contentMode = contentMode
        backgroundImageView.layer.cornerRadius = cornerRadius
        backgroundImageView.layer.masksToBounds = cornerRadius > 0
    }
}

private extension MascotImageView {
    private func setupBackgroundImage() {
        // Ensure `translatesAutoresizingMaskIntoConstraints` is false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Add and constrain the background image view
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
