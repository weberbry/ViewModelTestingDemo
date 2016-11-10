//
//  SearchViewControllerViewModel.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/27/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

protocol SavedSettings {
    func set(_ value: Bool, forKey defaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: SavedSettings {}

class SearchViewModel {
    
    //Require mocking for testing
    private let networkingLayer: NetworkingLayer
    
    var savedSettings: SavedSettings = UserDefaults.standard
    
    var albumViewModels: [AlbumSearchResultCellViewModel] = []
    private let hasPreviouslyLoadedKey = "hasPreviouslyLoaded"
    
    var hasPreviouslyLoaded: Bool {
        return savedSettings.bool(forKey: hasPreviouslyLoadedKey)
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
    
    func setHasPreviouslyLoaded(hasPreviouslyLoaded: Bool) {
        savedSettings.set(hasPreviouslyLoaded, forKey: hasPreviouslyLoadedKey)
    }
}

