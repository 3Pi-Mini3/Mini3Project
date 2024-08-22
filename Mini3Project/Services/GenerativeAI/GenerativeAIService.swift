//
//  GenerativeAIService.swift
//  Mini3Project
//
//  Created by Agfi on 16/08/24.
//

import Foundation
import GoogleGenerativeAI

class GenerativeAIService {
    private lazy var model: GenerativeModel = {
        let apiKey = fetchAPIKey()
        return GenerativeModel(name: "gemini-pro", apiKey: apiKey)
    }()
    
    private var conversationHistory: [String] = []
    
    func generateResponse(for prompt: String) async throws -> String {
        // Add the new prompt to the conversation history
        conversationHistory.append("User: \(prompt)")
        
        // Combine the conversation history to provide context for the model
        let conversationContext = conversationHistory.joined(separator: "\n")
        
        // Pass the conversation context to the model
        let response = try await model.generateContent(conversationContext)
        
        // If the model generates a response, append it to the conversation history
        if let text = response.text {
            conversationHistory.append("AI: \(text)")
            return text
        }
        
        return "No response generated."
    }
    
    func generateOneResponse(for prompt: String) async throws -> String {
        let response = try await model.generateContent(prompt)
        
        if let text = response.text {
            return text
        }
        
        return "No response generated."
    }
    
    func resetConversation() {
        conversationHistory.removeAll()
    }
    
    // Fetch the API key from Config.plist
    private func fetchAPIKey() -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let apiKey = dict["API_KEY"] as? String else {
            fatalError("API Key not found in Config.plist")
        }
        return apiKey
    }
}
