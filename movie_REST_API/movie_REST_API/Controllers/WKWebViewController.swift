//
//  WKWebViewController.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 28.10.2022.
//

import UIKit

import WebKit

/// Информация о фильме из сети
final class WKWebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Private Constant
    private enum Constant {
        static let backName = "chevron.left"
        static let forwardName = "chevron.forward"
        static let firstPartURLString = "https://api.themoviedb.org/3/movie/"
        static let secondPartURLString = "?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let errorString = "Error processing json data: "
    }
    
    // MARK: - Private Visual Components
    private let wkWebView = WKWebView()
    
    // MARK: - Private Properties
    private var apiService = ApiService()
    private var homePage: HomaPageData?
    private var urlString = String()
    
    // MARK: - Public Properties
    var id: Int?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createWkWebView()
        addConstraintWkWebView()
        fetchHomePageData(id: id) {}
    }
    
    // MARK: - Private Method
    private func fetchHomePageData(id: Int?, completion: @escaping () -> ()) {
        
        guard let idMovie = id else { return }
    
        let urlPage = Constant.firstPartURLString + String(idMovie) + Constant.secondPartURLString
        urlString = urlPage
        apiService.getHomePageData(moviesURL: urlPage) { [weak self] result in

            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                guard let list = list.homepage else { return }
                self?.getURL(url: list)
                completion()
            case let .failure(error):
                print(Constant.errorString, error)
            }
        }
    }
    
    private func getURL(url: String) {
        guard let myURL = URL(string: url) else { return }
        let request = URLRequest(url: myURL)
        wkWebView.load(request)
    }
    
    private func createWkWebView() {
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wkWebView)
    }
    
    private func addConstraintWkWebView() {
        NSLayoutConstraint.activate([
            wkWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wkWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wkWebView.topAnchor.constraint(equalTo: view.topAnchor),
            wkWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
