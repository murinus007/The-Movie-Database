//
//  DetailViewController.swift
//  Movie
//
//  Created by Alex Serhiiev on 15.03.2023.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var realeseDateLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var favourites = DataService.shared.getData()
    
    var data: ResultElement?
    
    var isFavourite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = data else { return }
        
        isFavourite = favourites.contains { model in
            data.id == model.id
        }
        
        if isFavourite {
            navigationItem.rightBarButtonItem = .init(title: nil, image: UIImage(systemName: "heart.fill"), target: self, action: #selector(favourite))
        } else {
            navigationItem.rightBarButtonItem = .init(title: nil, image: UIImage(systemName: "heart"), target: self, action: #selector(favourite))
        }
        
        let baceURL = "https://image.tmdb.org/t/p/w500"
                imageView.sd_setImage(with: .init(string: baceURL + data.posterPath))
        nameLabel.text = data.title ?? data.name
        realeseDateLabel.text = data.firstAirDate ?? data.releaseDate
        voteLabel.text = String(Double(round(data.voteAverage * 10) / 10))
        overviewLabel.text = data.overview
        MovieService.shared.getTrailer(movieId: String(data.id)) { trailer in
            guard !trailer.results.isEmpty else { return }
            self.playerView.load(withVideoId: trailer.results[0].key)
        }
    }
    
    @objc func favourite() {
        guard let data = data else { return }
        isFavourite.toggle()
        if isFavourite {
            navigationItem.rightBarButtonItem = .init(title: nil, image: UIImage(systemName: "heart.fill"), target: self, action: #selector(favourite))
        } else {
            navigationItem.rightBarButtonItem = .init(title: nil, image: UIImage(systemName: "heart"), target: self, action: #selector(favourite))
        }
        
        DataService.shared.saveData(data: DataModel(element: data))
    }

}
