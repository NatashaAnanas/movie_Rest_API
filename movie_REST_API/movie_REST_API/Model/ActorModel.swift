// ActorModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель  массив Актеры
struct ActorData: Decodable {
    let actor: [Actor]

    private enum CodingKeys: String, CodingKey {
        case actor = "cast"
    }
}

/// Модель Актеры
struct Actor: Decodable {
    let name: String?
    let actorImage: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case actorImage = "profile_path"
    }
}
