//
//  Card.swift
//  Flashzilla
//
//  Created by user256510 on 5/7/24.
//

import Foundation

struct Card : Codable, Identifiable, Equatable{
    var id = UUID()
    var prompt: String
    var answer: String
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.id == rhs.id
    }
    
    static let example = Card(prompt: "Who was the first pokemon ash caught?", answer: "Pik Achu")
}
