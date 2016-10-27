//
//  AlbumSearchResultCellViewModel.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/27/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

class AlbumSearchResultCellViewModel {
    
    let album: Album
    
    var title: String {
        return album.title
    }
    
    var details: String {
        return "\(album.artist) | \(album.releaseDate)"
    }
    
    var coverURL: URL {
        return album.imageURL
    }
    
    init(album: Album) {
        self.album = album
    }
}
