//
//  AppStatus.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import Foundation

enum AppStatus<T>: Equatable {
    case loading
    case error
    case success(T)

    static func == (lhs: AppStatus<T>, rhs: AppStatus<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.error, .error), (.success, .success):
            return true

        default: return false
        }
    }
}
