import UIKit
import Combine
import SwiftData

@MainActor
class ReflectionsViewModel {
    @Published var date: Date = Date()
    @Published var reflections: [Reflection] = []
    @Published var filteredReflections: [Reflection] = []
    @Published var skills: [Skill] = []
    
    var container: ModelContainer?
    
    init() {
        container = try? ModelContainer(for: Reflection.self, Skill.self)
    }
    
    func loadData() {
        let reflectionDescriptor = FetchDescriptor<Reflection>(
            sortBy: [SortDescriptor(\Reflection.createdAt, order: .forward)]
        )
        let skillDescriptor = FetchDescriptor<Skill>()
        reflections = (try? container?.mainContext.fetch(reflectionDescriptor)) ?? []
        skills = (try? container?.mainContext.fetch(skillDescriptor)) ?? []
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
        } catch {
            print("Failed to save new reflection and skills: \(error)")
        }
        
        loadData()
    }
    
    func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getReflectionDateFormatted(reflection: Reflection) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: reflection.createdAt)
    }
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
    
    func getCurrentYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func filterReflectionsByMonthAndYear() {
        let calendar = Calendar.current
        let targetComponents = calendar.dateComponents([.year, .month], from: date)
        
        filteredReflections = reflections.filter { reflection in
            let reflectionComponents = calendar.dateComponents([.year, .month], from: reflection.createdAt)
            return reflectionComponents.year == targetComponents.year && reflectionComponents.month == targetComponents.month
        }
    }
}
