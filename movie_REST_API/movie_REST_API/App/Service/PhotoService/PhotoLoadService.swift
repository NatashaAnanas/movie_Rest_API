// PhotoLoadService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

protocol PhotoLoadServiceProtocol {
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> ())
}

/// Сервис загрузки фотографий
final class PhotoLoadService: PhotoLoadServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.request(imageUrl).responseJSON { response in
            do {
                guard let data = response.data else { return }
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
