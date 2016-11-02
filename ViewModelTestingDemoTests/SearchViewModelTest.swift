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
}
