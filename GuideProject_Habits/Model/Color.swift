//
//  Color.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import Foundation

struct Color{
    let hue: Double
    let saturation: Double
    let brightness: Double
}

extension Color: Codable{
    enum CodingKeys: String, CodingKey {
        case hue = "h"
        case saturation = "s"
        case brightness = "b"
    }
}
