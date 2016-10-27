//
//  SearchViewController.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 10/25/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: UISearchBarDelegate
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { return }
        
        let networkingLayer = NetworkingLayer()
        networkingLayer.searchFor(searchTerm: searchTerm, type: .Album) { albums in
            self.albums = albums
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumSearchResultCell", for: indexPath) as! AlbumSearchResultTableViewCell
        let album = albums[indexPath.row]
        cell.titleLabel.text = album.title
        cell.artistLabel.text = album.artist
        cell.coverImageView.af_setImage(withURL: album.imageURL)
        return cell
    }
}
