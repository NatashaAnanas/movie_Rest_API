// InfoMoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol InfoMovieViewProtocol: AnyObject {
    func succes(data: Data)
    func failure(error: Error)
}

protocol InfoMovieViewPresenterProtocol: AnyObject {
    var movies: Movie { get set }
    init(
        view: InfoMovieViewProtocol,
        networkService: NetworkServiceProtocol,
        photoLoadService: PhotoLoadServiceProtocol,
        router: RouterProtocol,
        movies: Movie
    )
    func getImageDataFrom()
}

/// Презентер экрана с описанием фильмов
class InfoMoviePresenter: InfoMovieViewPresenterProtocol {
    // MARK: - Private Constant

    private enum Constant {
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
        static let emptyString = ""
    }

    let networkService: NetworkServiceProtocol?
    let photoLoadService: PhotoLoadServiceProtocol?
    var router: RouterProtocol
    var movies: Movie
    weak var view: InfoMovieViewProtocol?

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
        self.movies = movies
        getImageDataFrom()
    }

    // MARK: - Public Methods

    func getImageDataFrom() {
        let url = Constant.firstPartURLString + (movies.presentImageURLString ?? Constant.emptyString)
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
