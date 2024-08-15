//
//  Recommendation.swift
//  Mini3Project
//
//  Created by Agfi on 15/08/24.
//

import Foundation
import SwiftData

@Model
class Recommendation {
    var id: String?
    var name: String
    var role: String
    
    init(id: String? = nil, name: String, role: String) {
        self.id = id
        self.name = name
        self.role = role
    }
}
