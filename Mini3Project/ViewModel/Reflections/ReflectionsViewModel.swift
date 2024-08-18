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
    
    func generateData() {
        let reflection1 = Reflection(topic: "topic 1", answers: ["ans1", "ans2"], createdAt: Date())
        let reflection2 = Reflection(topic: "topic 2", answers: ["ans1", "ans2"], createdAt: Date())
        let reflection3 = Reflection(topic: "topic 3", answers: ["ans1", "ans2"], createdAt: Date())
        
        var reflection4: Reflection? = nil
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 7
        dateComponents.day = 18
        dateComponents.hour = 10
        dateComponents.minute = 30
        
        if let specificDate = Calendar.current.date(from: dateComponents) {
            reflection4 = Reflection(topic: "topic 4", answers: ["ans1", "ans2"], createdAt: specificDate)
        }
        
        container?.mainContext.insert(reflection1)
        container?.mainContext.insert(reflection2)
        container?.mainContext.insert(reflection3)
        
        if let reflection4 = reflection4 {
            container?.mainContext.insert(reflection4)
        }
        
        let skill1 = Skill(name: "softskill 1", role: "tech", type: "softskill", reflection: reflection1)
        let skill2 = Skill(name: "hardskill 1", role: "tech", type: "hardskill", reflection: reflection1)
        
        let skill3 = Skill(name: "softskill 2", role: "tech", type: "softskill", reflection: reflection2)
        let skill4 = Skill(name: "hardskill 2", role: "tech", type: "hardskill", reflection: reflection2)
        
        let skill5 = Skill(name: "softskill 3", role: "tech", type: "softskill", reflection: reflection3)
        let skill6 = Skill(name: "hardskill 3", role: "tech", type: "hardskill", reflection: reflection3)
        
        let skill7 = Skill(name: "hardskill 4", role: "tech", type: "hardskill", reflection: reflection4)
        
        container?.mainContext.insert(skill1)
        container?.mainContext.insert(skill2)
        container?.mainContext.insert(skill3)
        container?.mainContext.insert(skill4)
        container?.mainContext.insert(skill5)
        container?.mainContext.insert(skill6)
        container?.mainContext.insert(skill7)
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
    
    func filterReflectionsByMonthAndYear() {
        let calendar = Calendar.current
        let targetComponents = calendar.dateComponents([.year, .month], from: date)
        
        filteredReflections = reflections.filter { reflection in
            let reflectionComponents = calendar.dateComponents([.year, .month], from: reflection.createdAt)
            return reflectionComponents.year == targetComponents.year && reflectionComponents.month == targetComponents.month
        }
    }
}
