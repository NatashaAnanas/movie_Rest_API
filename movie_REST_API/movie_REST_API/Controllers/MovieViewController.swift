// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главная страница c фильмами
class ViewController: UIViewController {
    private enum Constant {
        static let filmIdentifier = "film"
    }

    private let popularButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .magenta
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let rateButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .magenta
        button.setTitle("Популярное", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constant.filmIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var viewModel = MovieViewModel()
    private var secondViewModel = ActorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        action()

        setConstraintTableView()
        setConstraintButtons()

        loadPopularMoviesData()
    }

    private func action() {
        popularButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }

    @objc private func buttonAction(sender: UIButton) {
        print("Hello")

        switch sender.tag {
        case 0:
            let url =
                "https://api.themoviedb.org/3/movie/top_rated?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"

            viewModel.urlMovie = url
            loadPopularMoviesData()

        case 1:
            let url =
                "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"

//        https://api.themoviedb.org/3/movie/436270/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US

            viewModel.urlMovie = url
            loadPopularMoviesData()
        default:
            break
        }
    }

    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func createTableView() {
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        view.addSubview(popularButton)
        view.addSubview(rateButton)
    }

    private func setConstraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: popularButton.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func setConstraintButtons() {
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularButton.widthAnchor.constraint(equalToConstant: 150),
            popularButton.heightAnchor.constraint(equalToConstant: 45),
        ])

        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rateButton.widthAnchor.constraint(equalToConstant: 150),
            rateButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.filmIdentifier,
            for: indexPath
        ) as? TableViewCell else { return UITableViewCell() }

        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(movie)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = SecondViewController()
        let navController = UINavigationController(rootViewController: secondVC)

        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        secondViewModel.id = movie.id
        secondVC.idNew = movie.id
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true)
    }
}
