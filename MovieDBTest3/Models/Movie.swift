//
//  Movie.swift
//  MovieDBTest3
//
//  Created by Ben Huggins on 2/22/19.
//  Copyright © 2019 User. All rights reserved.
//
// https://superheroapi.com/api/10219647583074874/search/batman


import Foundation

struct TopLevelJSON: Codable {
    let results: [Movie]
}
struct Movie: Codable {
    let title: String
    let rating: Double
    let overview: String
    let imageAsString: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case overview
        case imageAsString = "poster_path"
        }    
}
