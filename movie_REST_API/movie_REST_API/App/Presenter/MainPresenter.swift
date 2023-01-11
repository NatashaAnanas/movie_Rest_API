// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var movies: [Movie]? { get set }
    var urlMovie: String { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, urlMovie: String, router: RouterProtocol)
    func fetchMoviesData()
    func tapOnTheMovie(movie: Movie)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Movie
}

/// Презентер главного экрана со списком фильмов
class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol?
    var urlMovie: String
    var movies: [Movie]?
    var router: RouterProtocol?
    weak var view: MainViewProtocol?

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
        networkService?.getMoviesData(moviesURL: urlMovie) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.movies = movies
                self?.view?.succes()
            case let .failure(error):
                self?.view?.failure(error: error)
                print(error.localizedDescription)
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard let movies = movies else { return 0 }
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Movie {
        guard let movies = movies else { return Movie(json: nil) }
        return movies[indexPath.row]
    }

    func tapOnTheMovie(movie: Movie) {
        router?.showCurrentMovieVC(movie: movie)
    }
}
