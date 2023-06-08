//
//  PosterModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import Foundation

struct PosterModel {
    var baseURL = ""
    var lowResolutionPath = ""
    var hightResolutionPath = ""
    var originalResolutionPath = ""

    func getBaseURL(for resolution: PosterModel.Resoultion) -> String {
        var path = ""
        switch resolution {
        case .low:
            path = lowResolutionPath
        case .hight:
            path = hightResolutionPath
        case .original:
            path = originalResolutionPath
        }

        return baseURL.appending(path)
    }

    enum Resoultion {
        case low
        case hight
        case original
    }
}
