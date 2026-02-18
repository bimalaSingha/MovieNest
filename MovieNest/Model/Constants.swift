//
//  Constants.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/02/26.
//

import Foundation

struct Constants {
    static let apiKey = "98cf9448dcf5f4cd2e4a56c40665bb08"
    static let baseURL = "https://api.themoviedb.org/3"
    
    // Endpoint
    static let nowPlaying = "/movie/now_playing"
    
    /// infor --- https://api.themoviedb.org/3/movie/{movie_id}
    /// reviews --- https://api.themoviedb.org/3/movie/{movie_id}/reviews
    /// similar --- https://api.themoviedb.org/3/movie/{movie_id}/similar
           
//    static let reviews     = "/movie/reviews"
//    static let credits     = "/moviecredits"
//    static let similar     = "/movie/similar"
    static let imageBase   = "https://image.tmdb.org/t/p/w500"
}
