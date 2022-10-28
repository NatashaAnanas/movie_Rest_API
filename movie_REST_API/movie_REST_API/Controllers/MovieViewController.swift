// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главная страница c фильмами
final class MovieViewController: UIViewController {
    
    // MARK: - Private Constant
    private enum Constant {
        static let filmIdentifier = "film"
        static let allFilm = "Все фильмы"
        static let popularFilm = "Популярное"
        static let film = "Фильмы"
        static let urlAllFilm = "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let urlPopularFilm = "https://api.themoviedb.org/3/movie/top_rated?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let baseImage = "фон4"
        static let baseImageFilm = "film"
        static let newFilm = "Новинки"
    }
    
    // MARK: - Private Visual Components
    private let newButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle(Constant.newFilm, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let baseImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: Constant.baseImageFilm)
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let popularButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.layer.shadowRadius = 9.0
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)

        button.backgroundColor = .systemBlue
        button.setTitle(Constant.allFilm, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let rateButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 9.0
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        button.backgroundColor = .systemCyan
        button.setTitle(Constant.popularFilm, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = UIImageView(image: UIImage(named: Constant.baseImage))
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: Constant.filmIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var isPress = true

    private var viewModel = MovieViewModel()
    private var secondViewModel = ActorViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createTableView()
        action()

        setConstraintTableView()
        setConstraintButtons()
        setConstraintImage()
        setConstraintNewButton()

        loadPopularMoviesData()
    }

    // MARK: - Private Method
    private func action() {
        title = Constant.film
        popularButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }

    @objc private func buttonAction(sender: UIButton) {
        
        if isPress {
            popularButton.backgroundColor = .systemCyan
            rateButton.backgroundColor = .systemBlue
            isPress = false
        } else {
            popularButton.backgroundColor = .systemBlue
            rateButton.backgroundColor = .systemCyan
            isPress = true
        }
        
        switch sender.tag {
        case 0:
            let url = Constant.urlAllFilm
            viewModel.urlMovie = url
            loadPopularMoviesData()

        case 1:
            let url = Constant.urlPopularFilm
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
    
    private func createUI() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                    UIColor.black]
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constant.baseImage)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        view.addSubview(baseImageView)
        view.addSubview(tableView)
        view.addSubview(popularButton)
        view.addSubview(rateButton)
        view.addSubview(newButton)
    }

    private func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setConstraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: baseImageView.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func setConstraintButtons() {
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            popularButton.widthAnchor.constraint(equalToConstant: 150),
            popularButton.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            rateButton.widthAnchor.constraint(equalToConstant: 150),
            rateButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setConstraintImage() {
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: rateButton.bottomAnchor, constant: 10),
            baseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            baseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            baseImageView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    private func setConstraintNewButton() {
        NSLayoutConstraint.activate([
            newButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            newButton.heightAnchor.constraint(equalToConstant: 35),
            newButton.widthAnchor.constraint(equalToConstant: 120)
            ])
    }
}

// MARK: - Подписываемся на делегаты UITableViewDelegate, UITableViewDataSource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.filmIdentifier,
            for: indexPath
        ) as? MovieViewCell else { return UITableViewCell() }

        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(movie)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = InfoMovieViewController()
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        secondVC.idNew = movie.id
        secondVC.createPresentImage(image: movie.presentImage)
        secondVC.descpriptionTextView.text = movie.overview
        secondVC.nameFilmLabel.text = movie.title
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
