//
//  NetworkingLayer.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/26/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

enum SearchType {
    case Album
    
    var parameter: String {
        switch self {
        case .Album:
            return "album"
        }
    }
}

class NetworkingLayer {
    
    let baseSearchURLString = "https://itunes.apple.com/search?"
    
    func searchFor(searchTerm: String, type: SearchType, completionHandler:@escaping ([Album]) -> ()) {
        
        let url = URL(string: searchStringFor(searchTerm: searchTerm, type: type.parameter))
        let request = URLRequest(url: url!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                guard
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let albums = json?["results"] as? [[String: Any]]
                    else { return }
                
                var newAlbums: [Album] = []
                
                albums.forEach({ (album) in
                    guard
                        let title = album["collectionName"] as? String,
                        let artist =  album["artistName"] as? String,
                        let releaseDateString =  album["releaseDate"] as? String,
                        let releaseDate = self.dateFrom(string: releaseDateString),
                        let image =  album["artworkUrl60"] as? String,
                        let imageURL = URL(string: image)
                        else { return }
                    
                    let newAlbum = Album(title: title, artist: artist, releaseDate: releaseDate, imageURL:imageURL)
                    newAlbums.append(newAlbum)
                })
                
                completionHandler(newAlbums)
            }
        })
        task.resume()
    }
    
    private func searchStringFor(searchTerm: String, type: String) -> String {
        let searchTermWhitespaceRemoved = searchTerm.replacingOccurrences(of: " ", with: "+")
        return baseSearchURLString + "term=" + searchTermWhitespaceRemoved + "&entity=" + type
    }
    
    private func dateFrom(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter.date(from: string)
    }
}
