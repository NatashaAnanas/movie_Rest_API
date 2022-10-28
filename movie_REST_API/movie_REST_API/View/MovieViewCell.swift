// TableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фильмом
final class MovieViewCell: UITableViewCell {
    
    // MARK: - Private Constant
    private enum Constant {
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let firstPartURL =  "https://image.tmdb.org/t/p/w500"
        static let errorDataTaskText = "DataTask error: "
        static let emptyDataText = "Empty Data"
    }
    
    // MARK: - Private Visual Components
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    private let descpriptionMovieTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 18)
        text.backgroundColor = .none
        text.textColor = .black
        
        return text
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 18
        label.clipsToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalErrorText)
    }
    
    // MARK: - Public Methods
    func setCellWithValues(_ movie: Movie) {
        updateUI(
            title: movie.title,
            releaseDate: movie.year,
            rating: movie.rate,
            overview: movie.overview,
            poster: movie.posterImage,
            id: movie.id,
            posterImage: movie.presentImage)
    }
    
    // MARK: - Private Methods
    private func createUI() {
        backgroundColor = .black
        addSubview(movieImageView)
        movieImageView.addSubview(rateLabel)
        addSubview(nameMovieLabel)
        addSubview(descpriptionMovieTextView)
    }
    
    private func setConstraints() {
        setConstraintImageView()
        setConstraintLabel()
        setConstraintTextView()
        setConstraintRateLabel()
    }
    
    private func setConstraintImageView() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            movieImageView.widthAnchor.constraint(equalToConstant: 190),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 5 / 3),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setConstraintLabel() {
        NSLayoutConstraint.activate([
            nameMovieLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameMovieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            nameMovieLabel.widthAnchor.constraint(equalToConstant: 210),
            nameMovieLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setConstraintTextView() {
        NSLayoutConstraint.activate([
            descpriptionMovieTextView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 5),
            descpriptionMovieTextView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            descpriptionMovieTextView.widthAnchor.constraint(equalToConstant: 200),
            descpriptionMovieTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setConstraintRateLabel() {
        NSLayoutConstraint.activate([
            rateLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -3),
            rateLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -3),
            rateLabel.widthAnchor.constraint(equalToConstant: 36),
            rateLabel.heightAnchor.constraint(equalTo: rateLabel.widthAnchor)
        ])
    }
    
    private func updateUI(
        title: String?,
        releaseDate: String?,
        rating: Double?,
        overview: String?,
        poster: String?,
        id: Int?,
        posterImage: String?
    ) {
        nameMovieLabel.text = title
        descpriptionMovieTextView.text = overview
        
        guard let rate = rating else { return }
        rateLabel.text = String(rate)
        switch rate {
        case 0.0...4.5:
            rateLabel.backgroundColor = .systemRed
        case 4.6...7.4:
            rateLabel.backgroundColor = .systemYellow
        case 7.5...10.00:
            rateLabel.backgroundColor = .systemGreen
        default:
            break
        }
        
        guard let imageString = poster else { return }
        let urlString = Constant.firstPartURL + imageString
        
        guard let imageURL = URL(string: urlString) else { return }
        getImageDataFrom(url: imageURL)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print(Constant.errorDataTaskText, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print(Constant.emptyDataText)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.movieImageView.image = image
                }
            }
        }.resume()
    }
}
