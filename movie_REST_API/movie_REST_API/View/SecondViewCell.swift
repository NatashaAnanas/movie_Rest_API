// SecondViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейк с фотографиями актеров
class SecondCell: UICollectionViewCell {
    var personImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.image = UIImage(systemName: "star")
        image.backgroundColor = .yellow
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .systemMint
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
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraintsImage() {
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            personImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            personImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            personImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setConstraintsLabel() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
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
        let urlString = "https://image.tmdb.org/t/p/w500" + imageString

        guard let imageURL = URL(string: urlString) else {
            personImageView.image = UIImage(systemName: "star")
            return
        }

        //            self.movieImageView.image = UIImage(systemName: "star")

        getImageDataFrom(url: imageURL)
    }

    // MARK: - Get image data

    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in

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
                    self.personImageView.image = image
                }
            }
        }.resume()
    }
}
