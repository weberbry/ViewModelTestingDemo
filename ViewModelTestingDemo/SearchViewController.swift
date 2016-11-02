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
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: UISearchBarDelegate
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { return }
        
        viewModel.searchFor(searchTerm: searchTerm) { [weak self] in
            DispatchQueue.main.sync {
                self?.tableView.reloadData()
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumSearchResultCell", for: indexPath) as! AlbumSearchResultTableViewCell
        let albumViewModels = viewModel.albumViewModelAt(index: indexPath.row)
        cell.titleLabel.text = albumViewModels.title
        cell.detailsLabel.text = albumViewModels.details
        cell.coverImageView.af_setImage(withURL: albumViewModels.coverURL)
        return cell
    }
}
