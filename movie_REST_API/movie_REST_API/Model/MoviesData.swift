//
//  Model.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 27.10.2022.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let id: Int?
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

struct ActorData: Decodable {
    let actor: [Actor]
    
    private enum CodingKeys: String, CodingKey {
        case actor = "cast"
    }
}
struct Actor: Decodable {
    
    let name: String?
    let actorImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case actorImage = "profile_path"
    }
}
