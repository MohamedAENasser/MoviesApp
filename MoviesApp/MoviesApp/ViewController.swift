//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import UIKit

class ViewController: UIViewController {
    var moviesService: MoviesServiceProtocol = MoviesService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            let result = await moviesService.getMovies()
            print(result)
        }
    }


}

