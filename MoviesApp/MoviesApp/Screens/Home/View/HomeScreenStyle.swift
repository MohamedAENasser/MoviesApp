//
//  HomeScreenStyle.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import Foundation

enum HomeScreenStyle {
    case list
    case compact

    var iconName: String {
        switch self {
        case .list:
            return "list.dash"
        case .compact:
            return "circle.grid.3x3.fill"
        }
    }
}
