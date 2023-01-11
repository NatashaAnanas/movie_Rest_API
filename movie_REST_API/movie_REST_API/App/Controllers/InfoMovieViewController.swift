// InfoMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Страница с информацией о выбранном фильме
final class InfoMovieViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let cellIdentifier = "cell"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
        static let starImageName = "star"
        static let starFillImageName = "star.fill"
        static let emptyString = ""
        static let baseImageName = "фон5"
        static let watchString = "Смотреть"
        static let systemFontDescpriptionText: CGFloat = 22
    }

    // MARK: - Privat Visual Components

    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .none
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()

    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let goToWebButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.watchString, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPurple
        button.setTitleColor(UIColor.black, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Visual Components

    let descpriptionTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: Constants.systemFontDescpriptionText)
        text.backgroundColor = .none
        text.textColor = .black
        text.textAlignment = .center
        text.showsVerticalScrollIndicator = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    let nameFilmLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var isPressed = false

    // MARK: - Public Properties

    var presenter: InfoMovieViewPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavController()
        setConstraints()
    }

    // MARK: - Public Methods

    func createPresentImage() {
        presenter?.fetchImageDataFrom()
    }

    // MARK: - Private Methods

    private func setConstraints() {
        setLabelConstraints()
        setImageConstraints()
        setTextViewConstraints()
        setLabelConstraints()
        setButtonConstraints()
    }

    private func createUI() {
        view.backgroundColor = .black
        createBackground()
        addUI()
    }

    private func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constants.baseImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    private func addUI() {
        view.addSubviews(nameFilmLabel, movieImageView, descpriptionTextView, goToWebButton)
    }

    private func createNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.starImageName),
            style: .done,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: nameFilmLabel.bottomAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }

    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            nameFilmLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            nameFilmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameFilmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameFilmLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    private func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            descpriptionTextView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            descpriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descpriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descpriptionTextView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }

    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            goToWebButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 335),
            goToWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            goToWebButton.heightAnchor.constraint(equalToConstant: 40),
            goToWebButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

// MARK: - Подписываемся на протокол InfoMovieViewProtocol

extension InfoMovieViewController: InfoMovieViewProtocol {
    func succes(data: Data) {
        guard let image = UIImage(data: data) else { return }
        movieImageView.image = image
    }

    func failure(error: Error) {
        showAlert(title: nil, message: error.localizedDescription, handler: nil)
    }
}
