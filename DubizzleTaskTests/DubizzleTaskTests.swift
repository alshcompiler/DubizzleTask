//
//  DubizzleTaskTests.swift
//  DubizzleTaskTests
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import XCTest
@testable import DubizzleTask

class DubizzleTaskTests: XCTestCase {
    

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    
// i really couldn't make more test cases since there is literally no offline logic, so i have tested the API call to make sure it's returning data with no errors
    func testFetchItemsAPI() throws {
        let promise = expectation(description: "data retrieved!")
        var responseError: Error?
        var dataRetrieved: Bool = false
        ItemsRouter.items.send(ItemsResult.self, then: { response in
            switch response {
            case .failure(let error):
                responseError = error
            case .success(let itemsResult):
                dataRetrieved = (itemsResult.results?.count ?? 0) > 0
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 15)
        XCTAssertNil(responseError)
        XCTAssertTrue(dataRetrieved)
    }
    
    func testDetailsPageCreationType() {
        let item = ItemModel(createdAt: "2019-04-15 13:38:53.687469", price: "AED 2000", name: "New Item", uid: "", imageIDS: [], imageUrls: [], imageUrlsThumbnails: [])
        let detailsPageViewController = DetailsPageRouter.createModule(with: item)
        XCTAssertTrue(detailsPageViewController is DetailsPageViewController)
    }
    
    func testDetailsPageEntity() {
        let item = ItemModel(createdAt: "2019-04-15 13:38:53.687469", price: "AED 2000", name: "New Item", uid: "", imageIDS: [], imageUrls: [], imageUrlsThumbnails: [])
        let detailsPageViewController = DetailsPageRouter.createModule(with: item)
        XCTAssertTrue((detailsPageViewController as? DetailsPageViewController)?.presenter?.getItem() != nil)
    }
}
