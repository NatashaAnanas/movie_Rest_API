// SecondViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных об актерах
class ActorViewModel {
    private var apiService = ApiService()
    private var actors: [Actor] = []
    private var viewModel = MovieViewModel()
    var id: Int?

    func fetchPopularMoviesData(id: Int?, completion: @escaping () -> ()) {
        print("API в ActorViewModel = \(id)")
        guard let idMovie = id else { return }
        let urlActor =
            "https://api.themoviedb.org/3/movie/\(idMovie)/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US"
        apiService.getActorData(actorURL: urlActor) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.actors = list.actor
                completion()
            case let .failure(error):
                print("Error processing json data: \(error)")
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if actors.count != 0 {
            return actors.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Actor {
        actors[indexPath.row]
    }
}
