//
//  HomeScreenViewControllerTests.swift
//  MoviesAppTests
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import XCTest
import Moya
import Combine
@testable import MoviesApp

final class HomeScreenViewControllerTests: XCTestCase {
    var viewController: HomeScreenViewController!
    var service: HomeScreenServiceProtocol!

    override func setUp() {
        super.setUp()

        let homeScreenStoryboard = UIStoryboard(name: Constants.StoryBoardIDs.homeScreen, bundle: .main)
        viewController = try? XCTUnwrap(homeScreenStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.homeScreenViewController) as? HomeScreenViewController)

        service = HomeScreenService(provider: MoyaProvider<MoviesTarget>(stubClosure: MoyaProvider.immediatelyStub))
        viewController.viewModel = HomeScreenViewModel(service: service)
        _ = viewController.view
    }

    override func tearDown() {
        service = nil
        viewController = nil

        super.tearDown()
    }

    func testSetupDataWithSuccessResponse() {
        updateStubFilePath(with: .success)
        viewController.viewDidLoad()

        let exp = expectation(description: #function)

        var resultingStatus: AppStatus<[Movie]> = .loading
        viewController.viewModel.$status.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { status in
                guard case .success = status, resultingStatus != status else { return }
                resultingStatus = status
                exp.fulfill()
                
            })
        )

        wait(for: [exp], timeout: 5)

        guard case .success = resultingStatus else {
            XCTFail("Status was not updated properly")
            return
        }
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), viewController.viewModel.numberOfItems())
    }

    func testSetupDataWithFailureResponse() {
        updateStubFilePath(with: .failure)
        viewController.viewDidLoad()

        let exp = expectation(description: #function)

        var resultingStatus: AppStatus<[Movie]> = .loading
        viewController.viewModel.$status.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { status in
                guard status == .error, resultingStatus != status else { return }
                resultingStatus = status
                exp.fulfill()

            })
        )

        wait(for: [exp], timeout: 5)

        XCTAssertEqual(resultingStatus, .error)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), viewController.viewModel.numberOfItems())
    }
}
