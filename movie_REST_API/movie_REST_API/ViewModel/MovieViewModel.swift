// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных о фильмах
class MovieViewModel {
    private var apiService = ApiService()
    private var popularMovies: [Movie] = []
    var urlMovie =
        "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"

    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        print(urlMovie)
        apiService.getMoviesData(moviesURL: urlMovie) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.popularMovies = list.movies
                completion()
            case let .failure(error):
                print("Error processing json data: \(error)")
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Movie {
        popularMovies[indexPath.row]
    }
}
