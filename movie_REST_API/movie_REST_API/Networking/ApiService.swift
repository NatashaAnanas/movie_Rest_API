// ApiService.swift
// Copyright © RoadMap. All rights reserved.

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
        guard let url = URL(string: url) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print(Constant.errorDataTaskString, error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print(Constant.emptyResponseString)
                return
            }
            print(Constant.statusCodeString, response.statusCode)
            
            guard let data = data else {
                print(Constant.emptyDataString)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
