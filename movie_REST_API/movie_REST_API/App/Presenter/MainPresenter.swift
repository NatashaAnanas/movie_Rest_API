// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для MovieViewController
protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

/// Протокол презентера главного экрана со списком фильмов
protocol MainViewPresenterProtocol: AnyObject {
    var movie: [Movie]? { get set }
    var urlMovie: String { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, urlMovie: String, router: RouterProtocol)
    func fetchMoviesData()
    func onTap(movie: Movie)
    func numberOfRowsIn(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Movie
}

/// Презентер главного экрана со списком фильмов
final class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol?
    var urlMovie: String
    var movie: [Movie]?
    var router: RouterProtocol?
    weak var view: MainViewProtocol?

    // MARK: Init

    required init(
        view: MainViewProtocol,
        networkService: NetworkServiceProtocol,
        urlMovie: String,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.urlMovie = urlMovie
        self.router = router
        fetchMoviesData()
    }

    // MARK: - Public Methods

    func fetchMoviesData() {
        networkService?.fetchMoviesData(moviesURL: urlMovie) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.movie = movies
                self?.view?.succes()
            case let .failure(error):
                self?.view?.failure(error: error)
                print(error.localizedDescription)
            }
        }
    }

    func numberOfRowsIn(section: Int) -> Int {
        guard let movies = movie else { return 0 }
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Movie {
        guard let movies = movie else { return Movie(json: nil) }
        return movies[indexPath.row]
    }

    func onTap(movie: Movie) {
        router?.showCurrent(movie: movie)
    }
}
