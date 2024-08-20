//
//  BridgeChatViewController.swift
//  Mini3Project
//
//  Created by Jonathan Andrew Yoel on 20/08/24.
//

import UIKit

class BridgeChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a rectangle view
              let rectangleView = UIView()
              
              // Set the frame (position and size)
              rectangleView.frame = CGRect(x: 70, y: 173, width: 252, height: 391)
              
              // Set the background color for the rectangle
              rectangleView.backgroundColor = UIColor.lightGray
              
              // Add the rectangle to the main view
              self.view.addSubview(rectangleView)
              
              // Create the first label
              let label1 = UILabel()
              label1.text = "Ready? Let's start reflecting!"
              label1.font = UIFont.boldSystemFont(ofSize: 24)
              label1.textAlignment = .center
              label1.textColor = UIColor.white
              label1.sizeToFit()
              
              // Position the first label below the rectangle with 24 points distance
              label1.frame.origin = CGPoint(x: (self.view.frame.width - label1.frame.width) / 2,
                                            y: rectangleView.frame.maxY + 24)
              
              self.view.addSubview(label1)
              
              // Create the second label
              let label2 = UILabel()
              label2.text = "Try to respond seriously and attentively to discover and understand your strengths!"
              label2.font = UIFont.systemFont(ofSize: 18) // Regular font with size 18
              label2.textAlignment = .center
              label2.textColor = UIColor.white
              label2.numberOfLines = 0 // Allow multiple lines
              label2.frame = CGRect(x: 70, y: label1.frame.maxY + 8, width: 252, height: 0) // Initial height 0
              
              // Adjust the label size to fit the text
              label2.sizeToFit()
              
              // Center the label horizontally and ensure it doesn't exceed the width of the rectangle
              label2.frame.origin.x = 70 + (252 - label2.frame.width) / 2
              
              // Add the second label to the main view
              self.view.addSubview(label2)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
