//
//  Album.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/26/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

struct Album {
    let title: String
    let artist: String
    let imageURL: URL
    
    init(title: String, artist: String, imageURL: URL) {
        self.title = title
        self.artist = artist
        self.imageURL = imageURL
    }
    
}
