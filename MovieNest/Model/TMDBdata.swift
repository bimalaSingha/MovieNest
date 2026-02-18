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
    let id: Int
    
    // kept optional because /now_playing and /similar doesn'r return genres or vote data in the same shape
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case title, overview, id
        case releaseDate = "release_date"
        case posterPath  = "poster_path"
        case voteAverage = "vote_average"
        case voteCount   = "vote_count"
    }
}

// Detail endpoint   --- separate struct, has genres
struct MovieDetail: Codable {
    let id: Int
    let title: String
    let overview: String
    let genres: [Genre]
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres
        case voteAverage = "vote_average"
        case voteCount   = "vote_count"
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

