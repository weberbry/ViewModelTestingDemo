//
//  NetworkingLayer.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/26/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

enum SpotifySearchType {
    case Album
    
    var parameter: String {
        switch self {
        case .Album:
            return "album"
        }
    }
}

class NetworkingLayer {
    
    let baseSpotifySearchURLString = "https://api.spotify.com/v1/search?"
    
    func searchSpotifyFor(searchTerm: String, type: SpotifySearchType, completionHandler:@escaping ([Album]) -> ()) {
        
        let url = URL(string: spotifyAlbumSearchStringFor(searchTerm: searchTerm))
        let request = URLRequest(url: url!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                guard
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let items = json?["albums"] as? [String : Any],
                    let albums = items["items"] as? [[String: Any]]
                    else { return }
                
                var newAlbums: [Album] = []
                
                albums.forEach({ (album) in
                    guard
                        let name = album["name"] as? String,
                        let artists =  album["artists"] as? [[String: Any]],
                        let artist = artists.first?["name"] as? String,
                        let images =  album["images"] as? [[String: Any]],
                        let image = images.first?["url"] as? String,
                        let imageURL = URL(string: image)
                        else {
                            return
                    }
                    
                    let newAlbum = Album(title: title, artist: artist, imageURL:imageURL)
                    newAlbums.append(newAlbum)
                })
                
                completionHandler(newAlbums)
            }
        })
        task.resume()
    }
    
    private func spotifyAlbumSearchStringFor(searchTerm: String) -> String {
        let searchTermWhitespaceRemoved = searchTerm.replacingOccurrences(of: " ", with: "+")
        return baseSpotifySearchURLString + "q=" + searchTermWhitespaceRemoved + "&type=" + SpotifySearchType.Album.parameter
    }
}
