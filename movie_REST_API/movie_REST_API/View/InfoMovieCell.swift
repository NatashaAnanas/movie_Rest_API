// SecondViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейк с фотографиями актеров
final class InfoMovieCell: UICollectionViewCell {
    
    // MARK: - Private Constant
    private enum Constant {
        static let fatalError = "init(coder:) has not been implemented"
        static let firstPartURL =  "https://image.tmdb.org/t/p/w500"
        static let errorDataTask = "DataTask error: "
        static let emptyData = "Empty Data"
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(personImageView)
        setConstraintsImage()
        setConstraintsLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
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
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setCellWithValues(_ actor: Actor) {
        updateUI(actorImage: actor.actorImage, name: actor.name)
    }
    
    private func updateUI(actorImage: String?, name: String?) {
        label.text = name
        
        guard let imageString = actorImage else { return }
        let urlString = Constant.firstPartURL + imageString
        
        guard let imageURL = URL(string: urlString) else { return }
        
        getImageData(url: imageURL)
    }
    
    private func getImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print(Constant.errorDataTask, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print(Constant.emptyData)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.personImageView.image = image
                }
            }
        }.resume()
    }
}
