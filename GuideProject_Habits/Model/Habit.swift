//
//  Habit.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import Foundation

struct Habit{
    let name: String
    let category: Category
    let info: String
}

extension Habit: Codable{}

extension Habit: Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Habit: Comparable {
    static func < (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name < rhs.name
    }
}
