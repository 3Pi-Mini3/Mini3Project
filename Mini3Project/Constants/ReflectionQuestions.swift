//
//  ReflectionQuestions.swift
//  Mini3Project
//
//  Created by Lucky on 19/08/24.
//

import Foundation

struct ReflectionQuestions {    
    static let initialMessages: [String] = [
        "Hi friend! How’s your day? I hope you’ll be fine!", // Phase 1
        "Welcome to this step! Bebuz still with you!", // Phase 2
        "Wow you’re so amazing! Let’s continue to the last second step!", // Phase 3
        "Congrats, you have got in this last step!" // Phase 4
    ]
    
    static let questions: [[String]] = [
        ["Can you talk me through your recent project?", "Were there any new experiences or challenges you faced?"],
        ["Looking back, what were your thoughts and feelings while working on the project and after it was done?"],
        ["What actions or strategies did you use to tackle the new experiences or challenges you faced?", "What made you choose those approaches?"],
        ["What did you learn from this project experience?", "if you could go back and do it all over again, is there anything you’d approach differently?"]
    ]
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
