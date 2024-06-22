/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {

   // case bubblegum
   // case buttercup
  //  case indigo
    case lavender
   // case magenta
   // case navy
   // case orange
  //  case oxblood
    case periwinkle
   // case poppy
  //  case purple
    case seafoam
    case sky
  //  case tan
    case teal
  //  case yellow

    var accentColor: Color {
        switch self {
        case .lavender, .periwinkle, .seafoam, .sky, .teal: return .black
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
    
    static func random() -> Theme {
        let randomIndex = Int.random(in: 0..<Theme.allCases.count)
        return Theme.allCases[randomIndex]
    }
}
