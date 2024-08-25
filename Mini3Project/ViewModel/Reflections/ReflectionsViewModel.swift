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
            sortBy: [SortDescriptor(\Reflection.createdAt, order: .reverse)]
        )
        let skillDescriptor = FetchDescriptor<Skill>()
        reflections = (try? container?.mainContext.fetch(reflectionDescriptor)) ?? []
        skills = (try? container?.mainContext.fetch(skillDescriptor)) ?? []
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
