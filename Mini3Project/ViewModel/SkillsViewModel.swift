//
//  SkillsViewModel.swift
//  Mini3Project
//
//  Created by Agfi on 22/08/24.
//

import Foundation
import Combine
import SwiftData

@MainActor
class SkillsViewModel: ObservableObject {
    @Published var date: Date = Date()
    @Published var reflections: [Reflection] = []
    @Published var filteredReflections: [Reflection] = []
    @Published var skills: [Skill] = []
    
    var container: ModelContainer?
    
    init() {
        container = try? ModelContainer(for: Reflection.self, Skill.self)
        loadData()
    }
    
    func loadData() {
        let reflectionDescriptor = FetchDescriptor<Reflection>(
            sortBy: [SortDescriptor(\Reflection.createdAt, order: .forward)]
        )
        let skillDescriptor = FetchDescriptor<Skill>()
        reflections = (try? container?.mainContext.fetch(reflectionDescriptor)) ?? []
        skills = (try? container?.mainContext.fetch(skillDescriptor)) ?? []
    }
    
    func fetchSkills(forRole role: String? = nil, skillType type: String? = nil) -> [Skill] {
        guard let context = container?.mainContext else { return [] }
        
        // Fetch all skills sorted by name
        let fetchDescriptor = FetchDescriptor<Skill>(sortBy: [SortDescriptor(\Skill.name, order: .forward)])
        let allSkills = (try? context.fetch(fetchDescriptor)) ?? []
        
        // Filter skills based on role, and if type is provided, also filter by type
        var filteredSkills = allSkills.filter { $0.role == role }
        
        if let type = type, !type.isEmpty {
            filteredSkills = filteredSkills.filter { $0.type == type }
        }
        
        // Remove duplicates by name (case-insensitive)
        var uniqueSkills = [Skill]()
        var seenNames = Set<String>()
        
        for skill in filteredSkills {
            let lowercasedName = skill.name.lowercased()
            if !seenNames.contains(lowercasedName) {
                uniqueSkills.append(skill)
                seenNames.insert(lowercasedName)
            }
        }
        
        return uniqueSkills
    }
    
    func fetchAllSkills() -> [Skill] {
        guard let context = container?.mainContext else { return [] }
        
        // Fetch skills based on the role or soft skills
        let fetchDescriptor = FetchDescriptor<Skill>(sortBy: [SortDescriptor(\Skill.name, order: .forward)])
        let allSkills = (try? context.fetch(fetchDescriptor)) ?? []
        
        // Filter skills based on role and remove duplicates by name (case-insensitive)
        var uniqueSkills = [Skill]()
        var seenNames = Set<String>()
        
        for skill in allSkills {
            let lowercasedName = skill.name.lowercased()
            if !seenNames.contains(lowercasedName) {
                uniqueSkills.append(skill)
                seenNames.insert(lowercasedName)
            }
        }
        
        return uniqueSkills
    }
}
