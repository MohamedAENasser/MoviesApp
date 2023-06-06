//
//  AppStatus.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import Foundation

enum AppStatus<T> {
    case loading
    case error
    case success(T)
}
