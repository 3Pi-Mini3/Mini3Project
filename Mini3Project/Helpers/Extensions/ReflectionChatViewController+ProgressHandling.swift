//
//  ReflectionChatViewController+ProgressHandling.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import Foundation

extension ReflectionChatViewController {
    func updateProgressBar() {
        let questionsPerPhase = viewModel.calculateQuestionsPerPhase()
        let totalQuestions = viewModel.calculateTotalQuestions()
        
        let questionsUpToCurrent = (0..<viewModel.currentPhaseIndex).map { viewModel.questions[$0].count }.reduce(0, +) + viewModel.currentQuestionIndex + 1
        let progress = Float(questionsUpToCurrent) / Float(totalQuestions)
        
        progressBarView.updateProgressBar(progress)
        
        progressBarView.updateProgressLabel(text: "\(viewModel.currentQuestionIndex + 1) of \(questionsPerPhase)")
    }
    
    func startProgressLabel() {  
        let questionsPerPhase = viewModel.calculateQuestionsPerPhase()
        
        progressBarView.updateProgressLabel(text: "0 of \(questionsPerPhase)")
    }
}
