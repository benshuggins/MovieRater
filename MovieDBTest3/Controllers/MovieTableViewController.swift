//
//  MovieTableViewController.swift
//  MovieDBTest3
//
//  Created by Ben Huggins on 2/22/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieItems: [Movie] = [] {
        didSet {
            DispatchQueue.main.async{
                
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Ratings"
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        
        let movieItems = self.movieItems[indexPath.row]
        
        cell?.itemLandingPad = movieItems
        
        MovieController.fetchImageFor(item: movieItems) { (image) in
            DispatchQueue.main.async {
                
                cell?.movieImageView.image = image
            }
        }
        return cell ?? UITableViewCell()
    }
}
extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        MovieController.fetchMovies(movie: searchTerm) { (items)  in
            self.movieItems = items
            
        }
    }
}
