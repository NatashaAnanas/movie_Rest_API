// ApiService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Get Data
class ApiService {
    private var dataTask: URLSessionDataTask?

    func getMoviesData(moviesURL: String, completion: @escaping (Result<MoviesData?, Error>) -> ()) {
        getData(url: moviesURL, completion: completion)
    }

    func getActorData(actorURL: String, completion: @escaping (Result<ActorData?, Error>) -> ()) {
        getData(url: actorURL, completion: completion)
    }

    func getData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ()) {
        guard let url = URL(string: url) else { return }

        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                print("Empty Data")
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
