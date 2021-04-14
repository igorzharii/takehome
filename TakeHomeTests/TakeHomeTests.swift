
import XCTest
@testable import TakeHome

class TakeHomeTests: XCTestCase {
    
    var sut: PodcastPageManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PodcastPageManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testResetPage() {
        sut.resetCurrentPage()
        let currentPage = sut.getCurrentPage()
        XCTAssertEqual(currentPage, 1, "Podcast page successfully reset")
    }
    
    func testCurrentPageIncrease() {
        
        let oldPage = sut.getCurrentPage()
        sut.increaseCurrentPage()
        let newPage = sut.getCurrentPage()
        
        XCTAssertEqual(newPage, oldPage + 1, "Podcast page successfully increased")
    }
    
    func testSuccessfulAPICall() throws {
        let dataProvider = SearchResultDataProvider()
        var responseError: Error?
        var gotPodcasts: Bool = false
        
        let promise = expectation(description: "Got podcasts")
        
        dataProvider.getSearch(page: 1, query: "He", success: { podcasts in
            gotPodcasts = podcasts.count > 0
            promise.fulfill()
        }, failure: { error in
            responseError = error
            XCTFail("No results")
        })
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(gotPodcasts, true)
    }
    
    func testFailedAPICall() throws {
        let dataProvider = SearchResultDataProvider()
        var responseError: Error?
        var gotPodcasts: Bool = false
        
        let promise = expectation(description: "Got no podcasts")
        
        dataProvider.getSearch(page: 1, query: "Hello", success: { podcasts in
            gotPodcasts = podcasts.count > 0
            XCTFail("Got results")
        }, failure: { error in
            responseError = error
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        
        // responseError failes because server always responds with success but on production it should be otherwise
        XCTAssertNotNil(responseError)
        XCTAssertEqual(gotPodcasts, false)
    }

}
