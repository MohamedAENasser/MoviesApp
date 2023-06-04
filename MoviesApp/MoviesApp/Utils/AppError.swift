//
//  AppError.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Foundation

enum AppError: Error {
    case failedToLoadData
    case failedToParseData

    var description: String {
        switch self {
        case .failedToLoadData: return "We couldn't load your data\n please try again"
        case .failedToParseData: return "We couldn't parse the retrieved data"
        }
    }
}
