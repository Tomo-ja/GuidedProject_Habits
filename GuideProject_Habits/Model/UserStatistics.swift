//
//  UserStatistics.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-02.
//

import Foundation

struct UserStatistics {
    let user: User
    let habitCounts: [HabitCount]
}

extension UserStatistics: Codable {}
