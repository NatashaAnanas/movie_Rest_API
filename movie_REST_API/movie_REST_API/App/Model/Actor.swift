// Actor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель массив Актеры
struct ActorData: Decodable {
    /// массив актеров
    let actors: [Actor]

    private enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}

/// Модель Актеры
struct Actor: Decodable {
    /// имя актера
    var name: String?
    /// фото актера
    var actorImageURLString: String?

    init(json: JSON) {
        name = json["name"].string
        actorImageURLString = json["profile_path"].string
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case actorImageURLString = "profile_path"
    }
}
