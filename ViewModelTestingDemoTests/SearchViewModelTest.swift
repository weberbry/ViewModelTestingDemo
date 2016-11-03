//
//  SearchViewModelTest.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 11/1/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import XCTest
@testable import ViewModelTestingDemo

class SearchViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicAlbumSearch() {
       
        let album1 = Album(title: "Big Boat", artist: "Phish", releaseDate: Date(), imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        let album2 = Album(title: "Farmhouse", artist: "Phish", releaseDate: Date(), imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        let album3 = Album(title: "Billy Breathes", artist: "Phish", releaseDate: Date(), imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        
        let mockNetworkingLayer = MockNetworkingLayer(searchResults: [album1, album2, album3])
        let searchViewModel = SearchViewModel(networkingLayer: mockNetworkingLayer)
        
        let albumSearchExpectation = expectation(description: "Validation")
        
        searchViewModel.searchFor(searchTerm: "Phish") {
            XCTAssert(searchViewModel.albumViewModels.count == 3)
            
            let album = searchViewModel.albumViewModelAt(index: 1)
            XCTAssertEqual(album.title, "Farmhouse")
            albumSearchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 100) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testSortedAlbumSearch() {
        
        let album1 = Album(title: "Big Boat", artist: "Phish", releaseDate: Date(), imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        
        let twoYears = TimeInterval(60 * 60 * 24 * 365 * 2)
        let notCurrentDate = Date(timeIntervalSinceNow: -twoYears)
        
        let album2 = Album(title: "Farmhouse", artist: "Phish", releaseDate: notCurrentDate, imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        let album3 = Album(title: "Billy Breathes", artist: "Phish", releaseDate: notCurrentDate, imageURL: URL(string: "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/100x100bb.jpg")!)
        
        let mockNetworkingLayer = MockNetworkingLayer(searchResults: [album1, album2, album3])
        let searchViewModel = SearchViewModel(networkingLayer: mockNetworkingLayer)
        
        let albumSearchExpectation = expectation(description: "Validation")
        
        searchViewModel.searchFor(searchTerm: "Phish") {
            
            let album1 = searchViewModel.albumViewModelAt(index: 0)
            let album2 = searchViewModel.albumViewModelAt(index: 1)
            let album3 = searchViewModel.albumViewModelAt(index: 2)

            XCTAssertEqual(album1.title, "Big Boat")
            XCTAssertEqual(album2.title, "Billy Breathes")
            XCTAssertEqual(album3.title, "Farmhouse")
            
            albumSearchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 100) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testHasLoaded() {
        let mockUserDefaults = MockUserDefaults()
        let searchViewModel = SearchViewModel()
        searchViewModel.userDefaults = mockUserDefaults
        
        XCTAssertFalse(searchViewModel.hasPreviouslyLoaded)
        
        searchViewModel.setHasPreviouslyLoaded(hasPreviouslyLoaded: true)
        
        XCTAssert(searchViewModel.hasPreviouslyLoaded)
    }
}
