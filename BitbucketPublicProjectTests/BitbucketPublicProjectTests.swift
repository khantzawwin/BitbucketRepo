//
//  BitbucketPublicProjectTests.swift
//  BitbucketPublicProjectTests
//
//  Created by Khant Zaw Win on 19/6/21.
//

import XCTest
@testable import BitbucketPublicProject

class BitbucketPublicProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRepositoriesSuccessReturnsRepositories() {
        // 1. given
        let urlString = "https://api.bitbucket.org/2.0/repositories"
        let repositoryExpectation = expectation(description: "repositories")
        var repositories: [Repository] = []
        
        // 2. when
        NetworkManager.shared.getRepositories(fromURLString: urlString) {  result in
            repositoryExpectation.fulfill()
            switch result{
            case .success(let repositoryResponse):
                repositories = repositoryResponse.values
            case .failure(_):
                repositories = []
            }
        }
        
        // 3. then
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(repositories.count,10)
        }
    }
    
    func testGetRepositoriesFailReturnInvalidURL() {
        // 1. given
        let urlString = ""
        let errorExpectation = expectation(description: "invalidError")
        let expectedError = NetworkError.invalidURL
        var actualError : NetworkError?
        var repositories: [Repository] = []
        
        // 2. when
        NetworkManager.shared.getRepositories(fromURLString: urlString) {  result in
            errorExpectation.fulfill()
            switch result{
            case .success(let repositoryResponse):
                repositories = repositoryResponse.values
            case .failure(let error):
                actualError = error
            }
        }
        
        // 3. then
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(actualError,expectedError)
        }
    }
    
    func testGetRepositoriesFailReturnUnableToComplete() {
        // 1. given
        let urlString = "abcd"
        let errorExpectation = expectation(description: "invalidError")
        let expectedError = NetworkError.unableToComplete
        var actualError : NetworkError?
        var repositories: [Repository] = []
        
        // 2. when
        NetworkManager.shared.getRepositories(fromURLString: urlString) {  result in
            errorExpectation.fulfill()
            switch result{
            case .success(let repositoryResponse):
                repositories = repositoryResponse.values
            case .failure(let error):
                actualError = error
            }
        }
        
        // 3. then
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(actualError,expectedError)
        }
    }
}
