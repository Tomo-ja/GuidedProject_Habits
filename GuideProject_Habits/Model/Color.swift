//
//  Color.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import UIKit

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

extension Color{
    var uiColor: UIColor {
        return UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1)
    }
}

extension Color: Hashable { }
