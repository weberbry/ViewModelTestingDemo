//
//  Album.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/26/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

struct Album {
    let name: String
    let artist: String
    let imageURL: URL
    
    init(name: String, artist: String, imageURL: URL) {
        self.name = name
        self.artist = artist
        self.imageURL = imageURL
    }
    
}
