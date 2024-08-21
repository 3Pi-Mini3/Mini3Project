//
//  ViewController.swift
//  Mini3Project
//
//  Created by Lucky on 14/08/24.
//

import Foundation

struct Utilities {
    static func getReflectionSkillsName(from reflection: Reflection, filteringBy skillType: String? = nil) -> [String] {
        guard let skills = reflection.skill else {
            return []
        }
        
        if let skillType = skillType {
            return skills.filter { $0.type == skillType }.map { $0.name }
        } else {
            return skills.map { $0.name }
        }
    }
    
    //    static func getReflectionSummary(from reflection: Reflection) -> String {
    //        return reflection.summary
    //    }
    
    static func getDateFormatted(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
