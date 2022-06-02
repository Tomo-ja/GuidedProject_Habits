//
//  Setting.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import Foundation

struct Settings{
    static var shared = Settings()
    
    enum Setting{
        static let favoriteHabits = "favoriteHabits"
        static let followedIDs = "followedIDs"
    }
    
    var favoriteHabits: [Habit]{
        get {
            return unarchiveJSON(key: Setting.favoriteHabits) ?? []
        }
        set{
            return archiveJSON(value: newValue, key: Setting.favoriteHabits)
        }
    }
    
    var followedUserIDs: [String]{
        get {
            return unarchiveJSON(key: Setting.followedIDs) ?? []
        }
        set {
            archiveJSON(value: newValue, key: Setting.followedIDs)
        }
    }
    
    private let defaults = UserDefaults.standard
    
    private func archiveJSON<T: Encodable>(value: T, key: String){
        let data = try! JSONEncoder().encode(value)
        let string = String(data: data, encoding: .utf8)
        defaults.set(string, forKey: key)
    }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key),
              let data = string.data(using: .utf8) else {
            return nil
        }
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    mutating func toggleFavorite(_ habit: Habit){
        var favorites = favoriteHabits
        
        if favorites.contains(habit) {
            favorites = favorites.filter{ $0 != habit }
        } else {
            favorites.append(habit)
        }
        favoriteHabits = favorites
    }
    
    mutating func toogleFollowed(user: User){
        var updated = followedUserIDs
        
        if updated.contains(user.id){
            updated = updated.filter{ $0 != user.id}
        } else {
            updated.append(user.id)
        }
        followedUserIDs = updated
    }
}
