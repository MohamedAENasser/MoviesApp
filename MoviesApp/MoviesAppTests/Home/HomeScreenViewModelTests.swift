//
//  HomeScreenViewModelTests.swift
//  MoviesAppTests
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import XCTest
import Moya
import Combine
@testable import MoviesApp

class HomeScreenViewModelTests: XCTestCase {
    var viewModel: HomeScreenViewModel!

    override func setUp() {
        super.setUp()

        viewModel = HomeScreenViewModel(service: HomeScreenService(provider: MoyaProvider<MoviesTarget>(stubClosure: MoyaProvider.immediatelyStub)))
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    func testGetMoviesWithSuccess() async {
        updateStubFilePath(with: .success)

        await viewModel.getMovies()

        guard case .success = viewModel.status else {
            XCTFail("Status was not updated properly")
            return
        }
    }

    func testGetMoviesWithFailure() async {
        updateStubFilePath(with: .failure)

        await viewModel.getMovies()

        XCTAssertEqual(viewModel.status, .error)
    }
}
