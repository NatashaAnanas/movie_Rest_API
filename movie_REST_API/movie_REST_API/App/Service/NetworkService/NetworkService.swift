// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

protocol NetworkServiceProtocol {
    func getData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ())
    func getDataSwiftyJSON(url: String, completion: @escaping (Result<JSON, Error>) -> ())
    func getMoviesData(moviesURL: String, completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ())
}

/// Cетевой слой
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constant

    private enum Constant {
        static let errorDataTaskString = "DataTask error: "
        static let emptyResponseString = "Empty Response"
        static let statusCodeString = "Response status code: "
        static let emptyDataString = "Empty Data"
        static let resultsString = "results"
        static let castString = "cast"
        static let mainURL = ""
    }

    // MARK: - Private Properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public Methods

    func getMoviesData(moviesURL: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        getDataSwiftyJSON(url: moviesURL) { result in
            switch result {
            case let .success(json):
                let movies = json[Constant.resultsString].arrayValue.map { Movie(json: $0) }
                completion(.success(movies))
            case let .failure(failure):
                completion(.failure(failure))
            }
        }
    }

    func getActorData(actorURL: String, completion: @escaping (Result<[Actor], Error>) -> ()) {
        getDataSwiftyJSON(url: actorURL) { result in
            switch result {
            case let .success(json):
                let actors = json[Constant.castString].arrayValue.map { Actor(json: $0) }
                completion(.success(actors))
            case let .failure(failure):
                completion(.failure(failure))
            }
        }
    }

    func getHomePageData(moviesURL: String, completion: @escaping (Result<HomaPageData?, Error>) -> ()) {
        getData(url: moviesURL, completion: completion)
    }

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        getData(url: imageUrl, completion: completion)
    }

    // MARK: - Private Methods

    internal func getData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ()) {
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

    internal func getDataSwiftyJSON(url: String, completion: @escaping (Result<JSON, Error>) -> ()) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case let .success(result):
                let json = JSON(result)
                completion(.success(json))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
