// Actor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель Актеры
struct Actor {
    /// Имя актера
    var name: String?
    /// Фото актера
    var actorImageURLString: String?

    init(json: JSON) {
        name = json["name"].string
        actorImageURLString = json["profile_path"].string
    }
}
