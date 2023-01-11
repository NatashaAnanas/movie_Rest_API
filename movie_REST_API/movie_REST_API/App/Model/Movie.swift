// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Moдель фильмы
struct Movie {
    /// Идентификатор фильма
    var id: Int?
    /// Название фильма
    var title: String?
    /// дДта релиза фильма
    var year: String?
    /// Рейтинг фильма
    var rate: Double?
    /// Ссылка на постер фильма
    var posterImageURLString: String?
    /// Краткое описание фильма
    var description: String?
    /// Ссылка на обложку фильма
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
}
