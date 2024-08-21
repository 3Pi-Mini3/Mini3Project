//
//  ViewController.swift
//  Mini3Project
//
//  Created by Lucky on 14/08/24.
//

import Foundation

struct Utilities {
    static func getReflectionSkills(from reflection: Reflection, filteringBy skillType: String? = nil) -> [Skill] {
        guard let skills = reflection.skill else {
            return []
        }

        if skillType == nil {
            return skills
        }

        return skills.filter { $0.type == skillType }
    }
    
//    static func getReflectionSummary(from reflection: Reflection) -> String {
//        return reflection.summary
//    }
}
