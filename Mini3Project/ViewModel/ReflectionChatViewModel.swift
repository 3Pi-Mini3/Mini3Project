//
//  ReflectionViewModel.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import Foundation

class ReflectionChatViewModel {
    private(set) var currentPhaseIndex: Int = 0
    private(set) var currentQuestionIndex: Int = 0
    private(set) var totalQuestionsCount: Int = 0
    private(set) var questionsPerPhase: Int = 0
    private(set) var reflections: String = ""
    
    // Make the setter for hasShownInitialMessage accessible
    var hasShownInitialMessage: Bool = false

    var questions: [[String]] = ReflectionQuestions.questions
    var initialMessages: [String] = ReflectionQuestions.initialMessages
    
    func getInitialMessage() -> String? {
        guard currentPhaseIndex < initialMessages.count else { return nil }
        return initialMessages[currentPhaseIndex]
    }
    
    func getCurrentQuestion() -> String? {
        guard currentPhaseIndex < questions.count,
              currentQuestionIndex < questions[currentPhaseIndex].count else { return nil }
        return questions[currentPhaseIndex][currentQuestionIndex]
    }
    
    func updateReflections(with newReflection: String) {
        reflections += newReflection
    }
    
    func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func moveToNextPhase() {
        currentPhaseIndex += 1
        currentQuestionIndex = 0
    }
    
    func shouldShowNextPhaseButton() -> Bool {
        return currentQuestionIndex >= questions[currentPhaseIndex].count
    }
    
    func isLastPhase() -> Bool {
        return currentPhaseIndex >= questions.count
    }
    
    func calculateQuestionsPerPhase() -> Int {
        guard currentPhaseIndex < questions.count else { return 0 }
        return questions[currentPhaseIndex].count
    }
    
    func calculateTotalQuestions() -> Int {
        return questions.flatMap { $0 }.count
    }
}
