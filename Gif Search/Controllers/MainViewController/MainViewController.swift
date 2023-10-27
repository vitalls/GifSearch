//
//  MainViewController.swift
//  Gif Search
//
//  Created by Виталий Минин on 25/10/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // constants for collectionview flowlayout
    let cellsPerRowPortrait = 3
    let cellsPerRowLandscape = 6
    
    var userDidScroll = false
    
    var viewModel: MainViewModel = MainViewModel()
    var cellDataSource: [Gif] = []
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getGifsData(forString: "Youtube")
    }
    func configView(){
        searchBar.backgroundImage = UIImage()
        setupCollectionView()
    }
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.cellDataSource.bind { [weak self] gifs in
            self?.cellDataSource = gifs
            self?.collectionView.reloadData()
        }
        viewModel.errorNotification.bind { [weak self] message in
            self?.showAlert(withMessage: message)
        }
    }
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
