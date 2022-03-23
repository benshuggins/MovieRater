//
//  MovieController.swift
//  MovieDBTest3
//
//  Created by Ben Huggins on 2/22/19.
//  Copyright © 2019 User. All rights reserved.
//

//30326cfda5a686ec399218dd1dfa8997 api key
//https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher

//https://api.themovied.org/3/search/movie?api_key=30326cfda5a686ec399218dd1dfa8997&query=Jack+Reacher

import Foundation
import UIKit

class MovieController  {
    
    static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
    static let apiKey = "30326cfda5a686ec399218dd1dfa8997"
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    //MARK: - Fetch Data
    static func fetchMovies(movie: String, completion: @escaping ([Movie]) -> Void ) {
        
        guard let url = baseURL else {completion([]); return}
        
        let movieQuery = URLQueryItem(name: "query", value: movie.lowercased())
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [apiKeyQuery,movieQuery]
        
        guard let requestURL = components?.url else {completion([]); return}
        let request = URLRequest(url: requestURL)
        
        print(request)
        print("🥯🥯🥯🥯🥯🥯🥯🥯\(requestURL)")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error fetching data \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {completion([]); return}
            
            
                     dump("🧄🧄🧄🧄\(data)" )
            
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelJSON = try jsonDecoder.decode(TopLevelJSON.self, from: data)
                let movieResults = topLevelJSON.results
                completion(movieResults)
                print(movieResults)
         
                
            } catch {
                
                print("Error decoding itunes items for \(error): \(error.localizedDescription)")
                completion([])
                
                return
            }
        }
        dataTask.resume()
    }
    //MARK: - Fetch Image
    static func fetchImageFor(item: Movie, completion: @escaping(UIImage?) -> Void) {
        
        guard let urlImage = item.imageAsString else { completion(nil); return}
        guard var url = baseImageURL else { completion(nil); return}
        url.appendPathComponent(urlImage)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(" \(String(describing: item.title)) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let image = UIImage(data: data)
            completion(image)
            
        }
        dataTask.resume()
        
    }
    
}














