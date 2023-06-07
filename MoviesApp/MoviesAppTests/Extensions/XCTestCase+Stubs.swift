//
//  XCTestCase+Stubs.swift
//  MoviesAppTests
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import XCTest
@testable import MoviesApp

extension XCTestCase {
    func updateStubFilePath(with status: SubStatus) {
        switch status {
        case .success:
            MoviesTarget.stubFilePath = Bundle.unitTests.path(forResource: "Success", ofType: "json") ?? ""
        case .failure:
            MoviesTarget.stubFilePath = Bundle.unitTests.path(forResource: "Error", ofType: "json") ?? ""
        }
    }

    enum SubStatus {
        case success
        case failure
    }
}
