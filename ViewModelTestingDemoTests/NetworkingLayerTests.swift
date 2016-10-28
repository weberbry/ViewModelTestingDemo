//
//  NetworkingLayerTests.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/27/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import ViewModelTestingDemo

class NetworkingLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumSearch() {
        
        stub(condition: isMethodGET()) { _ in
            let filePath = OHPathForFile("Fixtures.json", self.classForCoder)
            return OHHTTPStubsResponse(fileAtPath: filePath!,
                                       statusCode: 200,
                                       headers: [ "Content-Type": "application/json" ])
        }
        
        let networkLayer = NetworkingLayer()
        
        networkLayer.searchFor(searchTerm: "Phish", type: .Album) { albums in
            XCTAssert(albums.count == 3)
            
            let album = albums.first
            XCTAssertEqual(album?.title, "Big Boat")
            XCTAssertEqual(album?.artist, "Phish")
            XCTAssertEqual(album?.imageURL.absoluteString, "http://is1.mzstatic.com/image/thumb/Music71/v4/b1/f2/ae/b1f2ae1a-4f9f-5d5c-e5d5-a5eff1557059/source/60x60bb.jpg")
        }
    }    
}
