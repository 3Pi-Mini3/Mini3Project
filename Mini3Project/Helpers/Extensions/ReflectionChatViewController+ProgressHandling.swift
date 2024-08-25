//
//  ReflectionChatViewController+ProgressHandling.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import Foundation

extension ReflectionChatViewController {
    func updateProgressBar() {
        let totalQuestions = reflectionChatViewModel.calculateTotalQuestions()
        let totalPhase = reflectionChatViewModel.calculateTotalPhase()
        
        let questionsUpToCurrent = (0..<reflectionChatViewModel.currentPhaseIndex).map { reflectionChatViewModel.questions[$0].count }.reduce(0, +) + reflectionChatViewModel.currentQuestionIndex + 1
        let progress = Float(questionsUpToCurrent) / Float(totalQuestions)
        
        progressBarView.updateProgressBar(progress)
    }
    
    func updateProgressLabel() {  
        let totalPhase = reflectionChatViewModel.calculateTotalPhase()
        
        progressBarView.updateProgressLabel(text: "\(reflectionChatViewModel.currentPhaseIndex + 1) of \(totalPhase)")
    }
}
