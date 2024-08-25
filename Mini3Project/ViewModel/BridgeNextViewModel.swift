//
//  BridgeNextViewModel.swift
//  Mini3Project
//
//  Created by Lucky on 25/08/24.
//

import UIKit
import SwiftData

@MainActor
class BridgeNextViewModel {
    @Published var reflections: [Reflection] = []
    @Published var latestReflection: Reflection?
    @Published var skills: [Skill] = []
    
    var container: ModelContainer?
    
    init() {
        container = try? ModelContainer(for: Reflection.self, Skill.self)
        
        loadData()
    }
    
    func loadData() {
        let reflectionDescriptor = FetchDescriptor<Reflection>(
            sortBy: [SortDescriptor(\Reflection.createdAt, order: .reverse)]
        )
        let skillDescriptor = FetchDescriptor<Skill>()
        reflections = (try? container?.mainContext.fetch(reflectionDescriptor)) ?? []
        skills = (try? container?.mainContext.fetch(skillDescriptor)) ?? []
    }
    
    func getLatestReflection() {
        loadData()
        
        print("TES")
        // Find the most recent reflection
        guard let mostRecentReflection = reflections.max(by: { $0.createdAt < $1.createdAt }) else {
            latestReflection = nil
            print("No reflections found.")
            return
        }
        
        // Filter reflections to include only the most recent one
        latestReflection = mostRecentReflection
        
        print("Latest Reflection: \(latestReflection?.description ?? "No latest reflection")")
        
        print("TES2")
    }
}
