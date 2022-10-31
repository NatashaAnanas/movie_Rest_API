// MovieView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных о фильмах
final class MovieView {
    
    // MARK: - Private Constant
    private enum Constant {
        static let errorString = "Error processing json data: "
    }
    
    // MARK: - Public Properties
    var urlMovie = String()
    
    // MARK: - Private Properties
    private let apiService = ApiService()
    private var movies: [Movie] = []

    // MARK: - Public Methods
    func fetchMoviesData(completion: @escaping () -> ()) {
        apiService.getMoviesData(moviesURL: urlMovie) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.movies = list.movies
                completion()
            case let .failure(error):
                print(Constant.errorString, error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Movie {
        movies[indexPath.row]
    }
}
