//
//  SearchViewControllerViewModel.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/27/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

class SearchViewControllerViewModel {
    
    let networkingLayer = NetworkingLayer()
    var albumViewModels: [AlbumSearchResultCellViewModel] = []
    
    func searchFor(searchTerm: String, type: SearchType, completionHandler:@escaping () -> ()) {
        networkingLayer.searchFor(searchTerm: searchTerm, type: type) { [weak self] (albums) in
            
            self?.albumViewModels = albums.map( {AlbumSearchResultCellViewModel(album: $0)} )
            completionHandler()
        }
    }
    
    func albumViewModelAt(index: Int) -> AlbumSearchResultCellViewModel {
        return albumViewModels[index]
    }
}

