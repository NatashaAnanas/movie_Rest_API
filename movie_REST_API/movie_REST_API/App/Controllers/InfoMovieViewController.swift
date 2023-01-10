// SecondViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Страница выбранного фильма
final class InfoMovieViewController: UIViewController {
    
    // MARK: - Private Constant
    private enum Constant {
        static let cellIdentifier = "cell"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
        static let firstPartURLString =  "https://image.tmdb.org/t/p/w500"
        static let starImageName = "star"
        static let starFillImageName = "star.fill"
        static let emptyString = ""
        static let baseImageName = "фон5"
        static let watchString = "Смотреть"
    }
    
    // MARK: - Visual Components
    let descpriptionTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 22)
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
        button.setTitle( Constant.watchString, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPurple
        button.setTitleColor(UIColor.black, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Private Properties
    private let actorView = ActorView()
    private var isPressed = false
    
    // MARK: - Public Properties
    var idNew: Int?
    var router: Router?
    var presenter: InfoMovieViewPresenterProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavController()
        createCollectionView()
        setConstraints()
        action()
        loadMoviesData()
    }
    
    // MARK: - Public Method
    func createPresentImage() {
        presenter?.getImageDataFrom()
    }
    
    // MARK: - Private Method
    private func action() {
        goToWebButton.addTarget(self, action: #selector(goToWebButtonAction(sender: )), for: .touchUpInside)
    }
    
    private func setConstraints() {
        setLabelConstraints()
        setImageConstraints()
        setTextViewConstraints()
        setLabelConstraints()
        setCollectionViewConstraints()
        setButtonConstraints()
    }
    
    private func createUI() {
        view.backgroundColor = .black
        createBackground()
        addUI()
    }
    
    private func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constant.baseImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    private func addUI() {
        view.addSubviews(nameFilmLabel, movieImageView, descpriptionTextView, goToWebButton)
    }
    
    private func createNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constant.starImageName),
            style: .done,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func createCollectionView() {
        imageCollectionView.register(InfoMovieCell.self,
                                     forCellWithReuseIdentifier: Constant.cellIdentifier)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        view.addSubview(imageCollectionView)
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
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 300)
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
    
    private func loadMoviesData() {
        actorView.fetchMoviesData(id: idNew) { [weak self] in
            self?.imageCollectionView.reloadData()
        }
    }
    
    @objc func goToWebButtonAction(sender: UIButton) {
        let wkWebVC = WKWebViewController()
        wkWebVC.id = idNew
        navigationController?.pushViewController(wkWebVC, animated: true)
    }
}

// MARK: - Подписываемся на делегаты UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension InfoMovieViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actorView.numberOfRowsInSection(section: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.cellIdentifier,
            for: indexPath
        ) as? InfoMovieCell else { return UICollectionViewCell() }
        
        let actor = actorView.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(actor)
        cell.backgroundColor = .tertiaryLabel
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 200, height: 280)
    }
}

extension InfoMovieViewController: InfoMovieViewProtocol {
    func succes(data: Data) {
        guard let image = UIImage(data: data) else { return }
        self.movieImageView.image = image
    }
    
    func failure(error: Error) {
        showAlert(title: nil, message: error.localizedDescription, handler: nil)
    }
}
