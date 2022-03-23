//
//  MovieTableViewCell.swift
//  MovieDBTest3
//
//  Created by Ben Huggins on 2/22/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var itemLandingPad: Movie? {
        didSet{
            updateViews()
        }
    }
    func updateViews() {
        guard let unwrappedItem = itemLandingPad else {return}
        movieTitle.text = unwrappedItem.title
        movieRating.text = "\(unwrappedItem.rating)"
        movieBody.text = unwrappedItem.overview
        
    }
    //MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieBody: UILabel!
}
