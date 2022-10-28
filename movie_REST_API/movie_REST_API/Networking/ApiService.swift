// ApiService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Get Data - сетевой слой
final class ApiService {
    
    // MARK: - Private Constant
    private enum Constant {
        static let errorDataTask = "DataTask error: "
        static let emptyResponse = "Empty Response"
        static let statusCode = "Response status code: "
        static let emptyData = "Empty Data"
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
                print(Constant.errorDataTask, error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print(Constant.emptyResponse)
                return
            }
            print(Constant.statusCode, response.statusCode)
            
            guard let data = data else {
                print(Constant.emptyData)
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
