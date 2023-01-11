// AssembleBulder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AssembleBulderProtocol {
    func createMovieModul(router: RouterProtocol) -> UIViewController
    func createInfoMovieModul(router: RouterProtocol, movie: Movie) -> UIViewController
}

private enum Constants {
    static let allFilmURLString =
        "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
    static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
}

/// AssembleBulder
class AssembleBulder: AssembleBulderProtocol {
    // MARK: - Public Method

    func createMovieModul(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MovieViewController()
        let presenter = MainPresenter(
            view: view,
            networkService: networkService,
            urlMovie: Constants.allFilmURLString,
            router: router
        )
        view.presenter = presenter
        return view
    }

    func createInfoMovieModul(router: RouterProtocol, movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let photoLoadService = PhotoLoadService()
        let view = InfoMovieViewController()
        view.idNew = movie.id
        view.createPresentImage()
        view.descpriptionTextView.text = movie.description
        view.nameFilmLabel.text = movie.title

        let presenter = InfoMoviePresenter(
            view: view,
            networkService: networkService,
            photoLoadService: photoLoadService,
            router: router,
            movies: movie
        )
        view.presenter = presenter
        return view
    }
}
