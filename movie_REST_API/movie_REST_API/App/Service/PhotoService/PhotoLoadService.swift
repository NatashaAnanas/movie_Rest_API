//
//  PhotoLoadService.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 09.01.2023.
//

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
