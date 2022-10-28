// SecondViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных об актерах
final class ActorViewModel {
    
    // MARK: - Private Constant
    private enum Constant {
        static let firstPartURLString = "https://api.themoviedb.org/3/movie/"
        static let secondPartURLString = "/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US"
        static let errorString = "Error processing json data: "
    }
    
    // MARK: - Private Properties
    private let apiService = ApiService()
    private var actors: [Actor] = []

    // MARK: - Public Method
    func fetchMoviesData(id: Int?, completion: @escaping () -> ()) {
        
        guard let idMovie = id else { return }
        let urlActor = "\(Constant.firstPartURLString)\(String(idMovie))\(Constant.secondPartURLString)"
        apiService.getActorData(actorURL: urlActor) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.actors = list.actors
                completion()
            case let .failure(error):
                print(Constant.errorString, error)
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
