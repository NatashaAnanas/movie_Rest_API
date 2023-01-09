// ApiService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Get Data - сетевой слой
final class ApiService {
    
    // MARK: - Private Constant
    private enum Constant {
        static let errorDataTaskString = "DataTask error: "
        static let emptyResponseString = "Empty Response"
        static let statusCodeString = "Response status code: "
        static let emptyDataString = "Empty Data"
    }
    
    // MARK: - Private Properties
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public Methods
    func getMoviesData(moviesURL: String, completion: @escaping (Result<MoviesData?, Error>) -> ()) {
        getData(url: moviesURL, completion: completion)
    }
    
    func getActorData(actorURL: String, completion: @escaping (Result<ActorData?, Error>) -> ()) {
        getData(url: actorURL, completion: completion)
    }
    
    func getHomePageData(moviesURL: String, completion: @escaping (Result<HomaPageData?, Error>) -> ()) {
        getData(url: moviesURL, completion: completion)
    }
    
    // MARK: - Private Methods
    
    private func getData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ()) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
