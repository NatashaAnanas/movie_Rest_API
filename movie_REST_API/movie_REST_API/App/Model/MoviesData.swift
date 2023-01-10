// MoviesData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Moдель массив фильмов
struct MoviesData: Decodable {
    /// массив с фильмами
    var movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Moдель фильмы
struct Movie: Decodable {
    /// идентификатор фильма
    var id: Int?
    /// название фильма
    var title: String?
    /// дата релиза фильма
    var year: String?
    /// рейтинг фильма
    var rate: Double?
    /// ссылка на постер фильма
    var posterImageURLString: String?
    /// краткое описание фильма
    var description: String?
    /// ссылка на обложку фильма
    var presentImageURLString: String?
    
    init(json: JSON?) {
        id = json?["id"].int
        title = json?["title"].string
        year = json?["release_date"].string
        rate = json?["vote_average"].double
        posterImageURLString = json?["poster_path"].string
        description = json?["overview"].string
        presentImageURLString = json?["backdrop_path"].string
    }

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
