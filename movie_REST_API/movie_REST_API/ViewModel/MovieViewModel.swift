// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных о фильмах
class MovieViewModel {
    
    private enum Constant {
        static let urlMovie = "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let error = "Error processing json data: "
    }
    
    private var apiService = ApiService()
    private var movies: [Movie] = []
    var urlMovie = "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"

    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        apiService.getMoviesData(moviesURL: urlMovie) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.movies = list.movies
                completion()
            case let .failure(error):
                print(Constant.error, error)
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
