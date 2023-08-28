//
//  ConferenceTests.swift
//  ConferenceTests
//
//  Created by Pham, Ashley on 8/28/23.
//

import XCTest
@testable import Conference
import Combine

final class ConferenceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegisterUpdatesCache() throws {
        let service: ConferenceScheduleServiceHandler = MockService()
        let store: ConferenceScheduleDataStore = ConferenceScheduleDataStore()
        let repo: ConferenceScheduleRepository = ConferenceScheduleRepository(service: service, store: store)
        
        let loadingExpectation = XCTestExpectation(description: "Loading Result")
        let successExpectation = XCTestExpectation(description: "Success Result")
        
        var cancellables = Set<AnyCancellable>()
        
        repo.data.sink { (result) in
            switch result {
            case.loading:
                loadingExpectation.fulfill()
            case.success:
                successExpectation.fulfill()
            default:
                break
            }
        }.store(in: &cancellables)
        
        self.wait(for: [loadingExpectation, successExpectation], timeout: 20, enforceOrder: true)

    }

}
