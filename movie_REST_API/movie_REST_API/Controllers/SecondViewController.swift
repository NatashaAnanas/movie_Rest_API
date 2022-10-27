// SecondViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Страница выбранного фильма
class SecondViewController: UIViewController {
    private enum Constant {
        static let cellIdentifier = "cell"
    }

    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .magenta
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let descpriptionTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 18)
        text.text = "kjhgfdsdfghjkl;plkjhgfdsdfghklp;[';pfdsdfghkl;/lkjgfdszxcl;lk cxchkl;lkhgfdsdfghjkl;lkhgfzxghjk"
        text.backgroundColor = .black
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()

    let secondViewModel = ActorViewModel()

    var idNew: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setImageConstraints()
        setTextViewConstraints()
    }

    private func createUI() {
        view.backgroundColor = .black
        navigationItem.title = "Hello"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .done,
            target: self,
            action: nil
        )

        view.addSubview(movieImageView)
        view.addSubview(descpriptionTextView)

        createCollectionView()
        setCollectionViewConstraints()

        loadPopularMoviesData()
    }

    private func createCollectionView() {
        imageCollectionView.register(SecondCell.self, forCellWithReuseIdentifier: Constant.cellIdentifier)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        view.addSubview(imageCollectionView)
    }

    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    private func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            descpriptionTextView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            descpriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descpriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descpriptionTextView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func loadPopularMoviesData() {
        secondViewModel.fetchPopularMoviesData(id: idNew) { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        }
    }
}

extension SecondViewController: UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        secondViewModel.numberOfRowsInSection(section: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.cellIdentifier,
            for: indexPath
        ) as? SecondCell else { return UICollectionViewCell() }

        let actor = secondViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(actor)
//    https://api.themoviedb.org/3/movie/200?api_key=74b256bd9644791fa138aeb51482b3b8&l
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
