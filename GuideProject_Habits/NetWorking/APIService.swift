//
//  APIService.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import Foundation

struct HabitRequest: APIRequest {
    typealias Response = [String: Habit]
    
    var habitName: String?
    var path: String { "/habits"}
}
