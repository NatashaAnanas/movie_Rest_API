// ActorView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных об актерах
final class ActorView {
    // MARK: - Private Constant

    private enum Constant {
        static let firstPartURLString = "https://api.themoviedb.org/3/movie/"
        static let secondPartURLString = "/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US"
        static let errorString = "Error processing json data: "
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var actors: [Actor] = []

    // MARK: - Public Method

    func fetchMoviesData(id: Int?, completion: @escaping () -> ()) {
        guard let idMovie = id else { return }
        let urlActor = "\(Constant.firstPartURLString)\(String(idMovie))\(Constant.secondPartURLString)"

        networkService.getActorData(actorURL: urlActor) { [weak self] result in
            switch result {
            case let .success(actors):
                self?.actors = actors
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
