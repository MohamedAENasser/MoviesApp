//
//  GenreItemView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 05/06/2023.
//

import UIKit

class GenreItemView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    init(title: String) {
        super.init(frame: .zero)

        titleLabel.text = title
        setupViews()
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        addSubview(titleLabel)
    }

    func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
    }

    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: padding * 2),
            heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: padding * 2),
        ])
    }
}
