// MainRouter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол роутера
protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: AssembleBulderProtocol? { get set }
    func initialViewController()
    func showCurrentMovieVC(movie: Movie)
    func popToRoot()
}

/// Роутер
class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: AssembleBulderProtocol?

    init(navigationController: UINavigationController, builder: AssembleBulderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let movieVC = builder?.createMovieModul(router: self) else { return }
            navigationController.viewControllers = [movieVC]
        }
    }

    func showCurrentMovieVC(movie: Movie) {
        if let navigationController = navigationController {
            guard let infoMovieVC = builder?.createInfoMovieModul(router: self, movie: movie) else { return }
            navigationController.pushViewController(infoMovieVC, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
}
