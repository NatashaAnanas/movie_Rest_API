// SecondViewCell.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON
import UIKit

/// Ячейка с фотографиями актеров
final class InfoMovieCell: UICollectionViewCell {
    
    // MARK: - Private Constant
    private enum Constant {
        static let fatalErrorString = "init(coder:) has not been implemented"
        static let firstPartURLString =  "https://image.tmdb.org/t/p/w500"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
    }
    
    // MARK: - Private Visual Components
    private let personImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.backgroundColor = .none
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(personLabel, personImageView)
        setConstraintsImage()
        setConstraintsLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalErrorString)
    }
    
    // MARK: - Public Method
    func setCellWithValues(_ actors: Actor) {
        updateUI(actorImage: actors.actorImageURLString, name: actors.name)
    }
    
    // MARK: - Private Method
    private func setConstraintsImage() {
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            personImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            personImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            personImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    private func setConstraintsLabel() {
        NSLayoutConstraint.activate([
            personLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            personLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            personLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            personLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func updateUI(actorImage: String?, name: String?) {
        personLabel.text = name
        
        guard let imageString = actorImage else { return }
        let urlString = "\(Constant.firstPartURLString)\(imageString)"
        
        getImageData(url: urlString)
    }
    
    private func getImageData(url: String) {
        PhotoLoadService().fetchImage(imageUrl: url) { result in
            switch result {
            case .success(let success):
                guard let image = UIImage(data: success) else { return }
                self.personImageView.image = image
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
