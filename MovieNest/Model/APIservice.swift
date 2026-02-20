//
//  APIservice.swift
//  MovieNest
//
//  Created by K Bimala Singha on 18/02/26.
//

import Foundation

class MovieAPIService {
    static let shared = MovieAPIService()
    
    private init() {}

    // calling the first section from DetailPage controller

    func fetchDetail(movieId: Int, completion: @escaping (MovieDetail?) -> Void) {
        let url = "\(Constants.baseURL)/movie/\(movieId)?api_key=\(Constants.apiKey)"
        fetch(url, completion: completion)
    }
    
    func fetchReviews(movieId: Int, completion: @escaping ([Review]) -> Void) {
        let url = "\(Constants.baseURL)/movie/\(movieId)/reviews?api_key=\(Constants.apiKey)"
        fetch(url) { (response: ReviewResponse?) in
            completion(response?.results ?? [])
        }
    }
    func fetchCredits(movieId: Int, completion: @escaping ([CastMemb]) -> Void) {
        let url = "\(Constants.baseURL)/movie/\(movieId)/credits?api_key=\(Constants.apiKey)"
        fetch(url) { (response: CreditsResponse?) in
            completion(response?.cast ?? [])
        }
    }
    
    func fetchSimilar(movieId: Int, completion: @escaping ([Movie]) -> Void) {
        let url = "\(Constants.baseURL)/movie/\(movieId)/similar?api_key=\(Constants.apiKey)"
        fetch(url) { (response: SimilarResponse?) in
            completion(response?.results ?? [])
        }
    }
}

//  Generic fetch (this will handle all decoding in one place)
 private func fetch<T: Decodable>(_ urlString: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                        DispatchQueue.main.async { completion(nil) }
                        return
                    }
            print("Raw response: \(String(data: data, encoding: .utf8) ?? "unreadable")")
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(decoded) }
            } catch {
                print("Decoding error for \(T.self): \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }

