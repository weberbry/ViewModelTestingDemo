//
//  SearchViewControllerViewModel.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/27/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    private let networkingLayer: NetworkingLayer
    var albumViewModels: [AlbumSearchResultCellViewModel] = []
    var userDefaults = UserDefaults.standard
    private let hasLoadedKey = "hasLoaded"
    
    var hasLoaded: Bool {
        return userDefaults.bool(forKey: hasLoadedKey)
    }
    
    init(networkingLayer: NetworkingLayer = NetworkingLayer()) {
        self.networkingLayer = networkingLayer
    }
    
    func searchFor(searchTerm: String, completionHandler:@escaping () -> ()) {
        networkingLayer.searchFor(searchTerm: searchTerm) { [weak self] (albums) in
        
            let unsortedViewModels = albums.map( {AlbumSearchResultCellViewModel(album: $0)} )
            let currentViewModels = unsortedViewModels.filter({ $0.isCurrent })
            let sortedNotCurrentAlbums = unsortedViewModels.filter({ !$0.isCurrent }).sorted { $0.title < $1.title }
            self?.albumViewModels = currentViewModels + sortedNotCurrentAlbums
            
            completionHandler()
        }
    }
    
    func albumViewModelAt(index: Int) -> AlbumSearchResultCellViewModel {
        return albumViewModels[index]
    }
    
    func setHasLoaded(hasLoaded: Bool) {
        userDefaults.set(hasLoaded, forKey: hasLoadedKey)
        userDefaults.synchronize()
    }
}

