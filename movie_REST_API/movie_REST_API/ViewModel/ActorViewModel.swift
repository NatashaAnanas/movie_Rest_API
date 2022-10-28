// SecondViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных об актерах
class ActorViewModel {
    
    private enum Constant {
        static let firstPartURL = "https://api.themoviedb.org/3/movie/"
        static let secondPartURL = "/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US"
        static let error = "Error processing json data: "
    }
    
    private var apiService = ApiService()
    private var actors: [Actor] = []

    func fetchPopularMoviesData(id: Int?, completion: @escaping () -> ()) {
        
        guard let idMovie = id else { return }
        let urlActor = Constant.firstPartURL + String(idMovie) + Constant.secondPartURL
        apiService.getActorData(actorURL: urlActor) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.actors = list.actor
                completion()
            case let .failure(error):
                print(Constant.error, error)
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
