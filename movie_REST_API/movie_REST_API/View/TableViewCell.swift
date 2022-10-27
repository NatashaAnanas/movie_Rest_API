//
//  TableViewCell.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 27.10.2022.
//

import UIKit

/// Ячейка с фильмом
class TableViewCell: UITableViewCell {
    
    let actors = ActorViewModel()
    let secondCell = SecondCell()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let descpriptionMovieTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 18)
        text.backgroundColor = .black
        text.textColor = .white
        
        return text
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 18
        label.clipsToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private var urlString: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 190),
            
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 5/3),
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

        func setCellWithValues(_ movie: Movie) {
            updateUI(title: movie.title,
                     releaseDate: movie.year,
                     rating: movie.rate,
                     overview: movie.overview,
                     poster: movie.posterImage,
                     id: movie.id)
            actors.completion  = { num in

                print(num, movie.id ?? "ниче")
            }
            
            actors.id = movie.id
            print("Мой id = \(movie.id) -  \(actors.id) ")
        }
        
    private func updateUI(title: String?,
                          releaseDate: String?,
                          rating: Double?,
                          overview: String?,
                          poster: String?,
                          id: Int?) {
            
        nameMovieLabel.text = title
        descpriptionMovieTextView.text = overview
//        guard let movieId = id else { return }
//        print("Мой id = \(movieId)")
        //            self.movieYear.text = convertDateFormater(releaseDate)
        
        guard let rate = rating else { return }
        rateLabel.text = String(rate)
        
        guard let imageString = poster else { return }
        urlString = "https://image.tmdb.org/t/p/w500" + imageString
            
            guard let imageURL = URL(string: urlString) else {
                movieImageView.image = UIImage(systemName: "star")
                return
            }

//            self.movieImageView.image = UIImage(systemName: "star")
            
            getImageDataFrom(url: imageURL)
            
        }
        
        // MARK: - Get image data
        private func getImageDataFrom(url: URL) {
            URLSession.shared.dataTask(with: url) { data, res, error in

                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.movieImageView.image = image
                    }
                }
            }.resume()
        }
        
        // MARK: - Convert date format
//        func convertDateFormater(_ date: String?) -> String {
//            var fixDate = ""
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            if let originalDate = date {
//                if let newDate = dateFormatter.date(from: originalDate) {
//                    dateFormatter.dateFormat = "dd.MM.yyyy"
//                    fixDate = dateFormatter.string(from: newDate)
//                }
//            }
//            return fixDate
//        }

    }
