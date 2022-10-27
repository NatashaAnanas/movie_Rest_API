//
//  MovieViewModel.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 27.10.2022.
//

import Foundation

/// Главная страница с фильмами
class MovieViewModel {
    
    private var apiService = ApiService()
    private var popularMovies: [Movie] = []
    var urlMovie = "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        print(urlMovie)
        apiService.getMoviesData(moviesURL: urlMovie) { [weak self] result in
            
            switch result {
            case .success(let listOf):
                guard let list = listOf else { return }
                self?.popularMovies = list.movies
                completion()
            case .failure(let error):
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
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
