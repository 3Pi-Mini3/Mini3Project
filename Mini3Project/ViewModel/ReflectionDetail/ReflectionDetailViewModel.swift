import UIKit

class ReflectionDetailViewModel {
    private let reflection: Reflection
    
    init(reflection: Reflection) {
        self.reflection = reflection
    }
    
    func getReflection() -> Reflection {
        return reflection
    }
}
