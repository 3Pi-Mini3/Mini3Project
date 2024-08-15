//
//  Skill.swift
//  Mini3Project
//
//  Created by Agfi on 15/08/24.
//

import Foundation
import SwiftData

@Model
class Skill {
    var id: String?
    var name: String
    var role: String
    var type: String
    
    @Relationship var reflection: Reflection?
    
    init(id: String? = nil, name: String, role: String, type: String, reflection: Reflection? = nil) {
        self.id = id
        self.name = name
        self.role = role
        self.type = type
        self.reflection = reflection
    }
}
