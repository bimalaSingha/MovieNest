//
//  TMDBdata.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/02/26.
//

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let overview: String
    let releaseDate: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
