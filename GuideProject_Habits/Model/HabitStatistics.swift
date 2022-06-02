//
//  HabitStatistics.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-02.
//

import Foundation

struct HabitStatistics{
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable {}
