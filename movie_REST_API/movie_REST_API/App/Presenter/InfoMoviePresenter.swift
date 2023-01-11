// InfoMoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для InfoMovieViewController
protocol InfoMovieViewProtocol: AnyObject {
    func succes(data: Data)
    func failure(error: Error)
}

/// Протокол презентера экрана с описанием фильмов
protocol InfoMovieViewPresenterProtocol: AnyObject {
    var movie: Movie { get set }
    func fetchImageDataFrom()
}

/// Презентер экрана с описанием фильмов
final class InfoMoviePresenter: InfoMovieViewPresenterProtocol {
    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol?
    let photoLoadService: PhotoLoadServiceProtocol?
    var router: RouterProtocol
    var movie: Movie
    weak var view: InfoMovieViewProtocol?

    // MARK: Init

    required init(
        view: InfoMovieViewProtocol,
        networkService: NetworkServiceProtocol,
        photoLoadService: PhotoLoadServiceProtocol,
        router: RouterProtocol,
        movies: Movie
    ) {
        self.view = view
        self.networkService = networkService
        self.photoLoadService = photoLoadService
        self.router = router
        movie = movies
        fetchImageDataFrom()
    }

    // MARK: - Public Methods

    func fetchImageDataFrom() {
        guard let presentImageURLString = movie.presentImageURLString else { return }
        let url = "\(PhotoLoadService.Constant.firstPartURLString)\(presentImageURLString)"
        photoLoadService?.fetchImage(imageUrl: url, completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.view?.succes(data: data)
            case let .failure(failure):
                self?.view?.failure(error: failure)
            }
        })
    }
}
