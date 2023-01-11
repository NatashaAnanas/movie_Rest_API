// MainRouter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол роутера
protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: AssembleBuilderProtocol? { get set }
    func initialViewController()
    func showCurrent(movie: Movie)
    func popToRoot()
}

/// Роутер
final class Router: RouterProtocol {
    // MARK: - Public Properties

    var navigationController: UINavigationController?
    var builder: AssembleBuilderProtocol?

    // MARK: - Init

    init(navigationController: UINavigationController, builder: AssembleBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }

    // MARK: - Public Method

    func initialViewController() {
        if let navigationController = navigationController {
            guard let movieVC = builder?.makeMovieModule(router: self) else { return }
            navigationController.viewControllers = [movieVC]
        }
    }

    func showCurrent(movie: Movie) {
        if let navigationController = navigationController {
            guard let infoMovieVC = builder?.makeInfoMovieModule(router: self, movie: movie) else { return }
            navigationController.pushViewController(infoMovieVC, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
}
