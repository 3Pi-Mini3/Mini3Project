//
//  ReflectionViewModel.swift
//  Mini3Project
//
//  Created by Lucky on 23/08/24.
//

import UIKit
import SwiftData

@MainActor
class ReflectionChatViewModel: NSObject {
    
    @Published var reflections: [Reflection] = []
    
    private let aiService = GenerativeAIService()
    
    private(set) var currentPhaseIndex: Int = 0
    private(set) var currentQuestionIndex: Int = 0
    private(set) var totalQuestionsCount: Int = 0
    private(set) var questionsPerPhase: Int = 0
    private(set) var reflectionsChat: String = ""
    
    var topic: String = ""
    var hasShownInitialMessage: Bool = false

    var questions: [[String]] = ReflectionQuestions.questions
    var initialMessages: [String] = ReflectionQuestions.initialMessages
    
    var container: ModelContainer?
    
    override init() {
        container = try? ModelContainer(for: Reflection.self)
    }
    
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
        reflectionsChat += newReflection
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
    
    func calculateTotalQuestions() -> Int {
        return questions.flatMap { $0 }.count
    }
    
    func calculateTotalPhase() -> Int {
        return questions.count
    }
    
    func createReflection(topic: String, answers: [String], hardSkillsWithRoles: [(skill: String, role: String)], softSkills: [String], summary: String) {
        guard let context = container?.mainContext else {
            print("Error: Main context is nil")
            return
        }
        
        let newReflection = Reflection(topic: topic, answers: answers, summary: summary, createdAt: Date())
        
        context.insert(newReflection)
        
        for (skillName, role) in hardSkillsWithRoles {
            let skill = Skill(name: skillName, role: role, type: "hardskill", reflection: newReflection)
            context.insert(skill)
        }
        
        for skillName in softSkills {
            let skill = Skill(name: skillName, role: "softskill", type: "softskill", reflection: newReflection)
            context.insert(skill)
        }
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .saveCompletedNotification, object: nil)
        } catch {
            print("Failed to save new reflection and skills: \(error)")
        }
    }
    
    func generateSummaryAndSave() {
        
        let answers = [reflectionsChat]
        
        Task {
            do {
                let answersText = reflectionsChat
                print("Answer Text \(answersText)")
                
                let summary = try await aiService.generateOneResponse(for: "Only me a summary in one paragraph with list of hardskill and softskill that I learned from this reflection: \(answersText)")
                
                let rawHardSkills = try await aiService.generateOneResponse(for: "Please list only the technical or design-related skills mentioned in this reflection. Do not include any soft skills or personal qualities. Provide the list as plain text without bullet points or extra descriptions: \(summary)")
                
                let separatedHardSkills = rawHardSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
                print("Separated Hard Skills: \(separatedHardSkills)")
                
                let diagnoseRoleSkills = try await aiService.generateOneResponse(for: "\(separatedHardSkills) from these skills,  specifying the skills with a role (coding, design, or product) it is associated with. Just list the skills and role without further explanation for example UI/UX design: design, etc")
                print("Diagnose Raw Role Skills: \n \(diagnoseRoleSkills)")
                
                let rawSoftSkills = try await aiService.generateOneResponse(for: "Please list only the soft skills or personal qualities mentioned in this reflection. Do not include any technical or design-related skills. Provide the list as plain text without bullet points or extra descriptions: \(summary)")
                print("Softskills: \n \(rawSoftSkills)")
                
                let separatedSoftSkills = rawSoftSkills
                    .components(separatedBy: "\n")
                    .map { $0.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
                
                let skillsWithRoles = parseSkillsWithRoles(from: diagnoseRoleSkills)
                
                print(skillsWithRoles)
                
                createReflection(topic: topic, answers: answers, hardSkillsWithRoles: skillsWithRoles, softSkills: separatedSoftSkills, summary: summary)
            } catch {
                print("ERROR")
            }
        }
    }
    
    private func parseSkillsWithRoles(from response: String) -> [(skill: String, role: String)] {
        var skillsWithRoles: [(skill: String, role: String)] = []
        
        // Remove the "Skills:" prefix if it exists
        var cleanedResponse = response.replacingOccurrences(of: "Skills:\n", with: "")
        
        // Remove the bullet points and trim whitespace
        cleanedResponse = cleanedResponse.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Split the response into lines
        let lines = cleanedResponse.components(separatedBy: "\n")
        
        for line in lines {
            // Split each line by the colon to separate skill and role
            let components = line.components(separatedBy: ":")
            if components.count == 2 {
                let skill = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let role = components[1].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                skillsWithRoles.append((skill: skill, role: role))
            }
        }
        
        return skillsWithRoles
    }
}

extension Notification.Name {
    static let saveCompletedNotification = Notification.Name("saveCompletedNotification")
}
