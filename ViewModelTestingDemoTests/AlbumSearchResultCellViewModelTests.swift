//
//  AlbumSearchResultCellViewModelTests.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/28/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import XCTest
@testable import ViewModelTestingDemo

class AlbumSearchResultCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumSearchResultCellViewModelInit() {
        let album = Album(title: "Big Boat", artist: "Phish", releaseDate: Date(), imageURL: URL(string: "http://www.google.com")!)
        let viewModel = AlbumSearchResultCellViewModel(album: album)
        
        XCTAssertNotNil(viewModel)
    }
    
    func testAlbumSearchResultCellViewModelProperties() {
        let testDate = Date()
        
        let album = Album(title: "Big Boat", artist: "Phish", releaseDate: testDate, imageURL: URL(string: "http://www.google.com")!)
        let viewModel = AlbumSearchResultCellViewModel(album: album)

        let calendar = Calendar(identifier: .gregorian)
        
        let dateComponents = calendar.dateComponents([.year], from: testDate)
        let currentYear = String(dateComponents.year!)
        
        XCTAssertEqual(viewModel.title, "Big Boat")
        XCTAssertEqual(viewModel.details, "Phish | \(currentYear)")
        XCTAssertEqual(viewModel.coverURL.absoluteString, "http://www.google.com")
    }
    
    func testAlbumSearchResultCellViewModelisCurrent() {
        let currentDate = Date()
        
        let currentAlbum = Album(title: "Big Boat", artist: "Phish", releaseDate: currentDate, imageURL: URL(string: "http://www.google.com")!)
        let currentAlbumViewModel = AlbumSearchResultCellViewModel(album: currentAlbum)
        
        XCTAssert(currentAlbumViewModel.isCurrent)
        
        let twentyYears = TimeInterval(60 * 60 * 24 * 365 * 20)
        let notCurrentDate = Date(timeIntervalSinceNow: -twentyYears)
        
        let notCurrentAlbum = Album(title: "Billy Breathes", artist: "Phish", releaseDate: notCurrentDate, imageURL: URL(string: "http://www.google.com")!)
        let notCurrentAlbumViewModel = AlbumSearchResultCellViewModel(album: notCurrentAlbum)
        
        XCTAssert(!notCurrentAlbumViewModel.isCurrent)
    }    
}
