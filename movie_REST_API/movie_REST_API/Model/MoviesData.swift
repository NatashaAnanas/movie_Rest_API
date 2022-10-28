// MoviesData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Moдель массив фильмов
struct MoviesData: Decodable {
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Moдель фильмы
struct Movie: Decodable {
    let id: Int?
    let title: String?
    let year: String?
    let rate: Double?
    let posterImageURLString: String?
    let description: String?
    let presentImageURLString: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case year = "release_date"
        case rate = "vote_average"
        case posterImageURLString = "poster_path"
        case presentImageURLString = "backdrop_path"
    }
}
