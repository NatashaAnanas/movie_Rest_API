// AssembleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AssembleBuilderProtocol {
    func makeMovieModule(router: RouterProtocol) -> UIViewController
    func makeInfoMovieModule(router: RouterProtocol, movie: Movie) -> UIViewController
}

/// AssembleBulder
final class AssembleBuilder: AssembleBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MovieViewController()
        let presenter = MainPresenter(
            view: view,
            networkService: networkService,
            urlMovie: NetworkService.Constant.allFilmURLString,
            router: router
        )
        view.presenter = presenter
        return view
    }

    func makeInfoMovieModule(router: RouterProtocol, movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let photoLoadService = PhotoLoadService()
        let view = InfoMovieViewController()
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
