//
//  Bundle+UnitTests.swift
//  MoviesAppTests
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import Foundation

private class BundleClass {
}

extension Bundle {
    static let unitTests = Bundle(for: BundleClass.self)
}
