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
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var originalTitleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!

    var viewModel: MovieDetailsViewModel?
    lazy var shimmerView: MovieDetailsShimmerView = {
        Bundle.main.loadNibNamed("MovieDetailsShimmerView", owner: nil)?.first as? MovieDetailsShimmerView ?? MovieDetailsShimmerView(frame: .zero)
    }()

    init(movieModel: Movie) {
        super.init(nibName: Constants.NibNames.movieDetailsViewController, bundle: .main)

        viewModel = MovieDetailsViewModel(movieModel: movieModel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel?.loadDetails()
    }

    private func setupSuccessUI() {
        DispatchQueue.main.async {
            self.shimmerView.removeFromSuperview()

            guard let viewModel = self.viewModel else { return }

            self.titleLabel.text =  viewModel.getTitle()
            if let originalTitle = viewModel.getOriginalTitle() {
                self.originalTitleLabel.text =  originalTitle
                self.originalTitleLabelHeightConstraint.isActive = false
            } else {
                self.originalTitleLabelHeightConstraint.constant = 0
                self.originalTitleLabelHeightConstraint.isActive = true
            }
            self.overviewLabel.text =  viewModel.getOverview()
            self.ratingLabel.text =  viewModel.getRating()
            self.releaseDataLabel.text =  viewModel.getReleaseData()
            viewModel.getGenres().forEach { genre in
                self.genresStackView.addArrangedSubview(GenreItemView(title: genre.name))
            }
        }
    }

    private func setupShimmer() {
        containerView.addSubview(shimmerView)
        shimmerView.fill(in: containerView)
    }

    private func setupBindings() {
        viewModel?.$status.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] status in
                guard let self else { return }
                switch status {
                case .loading:
                    self.setupShimmer()
                case .success:
                    self.setupSuccessUI()
                }
            })
        )


        viewModel?.$image.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { image in
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            })
        )
    }
}
