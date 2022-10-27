//
//  ActorModel.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 27.10.2022.
//

import Foundation

/// Модель Актеры
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
