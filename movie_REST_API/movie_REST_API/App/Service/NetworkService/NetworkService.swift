// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ())
    func fetchDataSwiftyJSON(url: String, completion: @escaping (Result<JSON, Error>) -> ())
    func fetchMoviesData(moviesURL: String, completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ())
}

/// Cетевой слой
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constant

    enum Constant {
        static let allFilmURLString =
            "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
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

    func fetchMoviesData(moviesURL: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        fetchDataSwiftyJSON(url: moviesURL) { result in
            switch result {
            case let .success(json):
                let movies = json[Constant.resultsString].arrayValue.map { Movie(json: $0) }
                completion(.success(movies))
            case let .failure(failure):
                completion(.failure(failure))
            }
        }
    }

    func fetchActorData(actorURL: String, completion: @escaping (Result<[Actor], Error>) -> ()) {
        fetchDataSwiftyJSON(url: actorURL) { result in
            switch result {
            case let .success(json):
                let actors = json[Constant.castString].arrayValue.map { Actor(json: $0) }
                completion(.success(actors))
            case let .failure(failure):
                completion(.failure(failure))
            }
        }
    }

//
//    func fetchHomePageData(moviesURL: String, completion: @escaping (Result<HomaPageData?, Error>) -> ()) {
//        fetchData(url: moviesURL, completion: completion)
//    }

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        fetchData(url: imageUrl, completion: completion)
    }

    // MARK: - Private Methods

    internal func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ()) {
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

    internal func fetchDataSwiftyJSON(url: String, completion: @escaping (Result<JSON, Error>) -> ()) {
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
