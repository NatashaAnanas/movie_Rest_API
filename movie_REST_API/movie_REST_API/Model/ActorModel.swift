// ActorModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель массив Актеры
struct ActorData: Decodable {
    let actors: [Actor]

    private enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}

/// Модель Актеры
struct Actor: Decodable {
    let name: String?
    let actorImageURLString: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case actorImageURLString = "profile_path"
    }
}
