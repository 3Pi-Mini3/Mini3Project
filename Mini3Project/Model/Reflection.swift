//
//  Reflection.swift
//  Mini3Project
//
//  Created by Agfi on 15/08/24.
//

import Foundation
import SwiftData

@Model
class Reflection {
    var id: String?
    var topic: String = ""
    var answers: [String]
    var summary: String
    var createdAt: Date = Date()
    
    @Relationship(inverse: \Skill.reflection) var skill: [Skill]?
    
    init(id: String? = nil, topic: String, answers: [String], summary: String, createdAt: Date, skill: [Skill]? = nil) {
        self.id = id
        self.topic = topic
        self.answers = answers
        self.summary = summary
        self.createdAt = createdAt
        self.skill = skill
    }
    
    var description: String {
            return "Topic: \(topic), Summary: \(summary)"
    }
}
