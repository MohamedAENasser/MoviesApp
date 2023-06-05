//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 05/06/2023.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var genresStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!

    var viewModel: MovieDetailsViewModel?

    init(movieID: String) {
        super.init(nibName: Constants.NibNames.movieDetailsViewController, bundle: .main)

        viewModel = MovieDetailsViewModel(movieID: movieID)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel?.loadDetails()
    }

    private func setupUI() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return }

            self.titleLabel.text =  viewModel.getTitle()
            self.overviewLabel.text =  viewModel.getOverview()
            self.ratingLabel.text =  viewModel.getRating()
            self.releaseDataLabel.text =  viewModel.getReleaseData()
            viewModel.getGenres().forEach { genre in
                self.genresStackView.addArrangedSubview(GenreItemView(title: genre.name))
            }
        }
    }

    private func setupBindings() {
        viewModel?.$detailsModel.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] _ in
                guard let self else { return }
                self.setupUI()
            })
        )
    }
}
