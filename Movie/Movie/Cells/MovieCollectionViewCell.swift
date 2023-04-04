//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Alex Serhiiev on 13.03.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favouritePressed: (() -> ())?
    
    var isFavourite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteButton.setImage(.init(systemName: "heart"), for: .normal)
    }

    @IBAction func favouritePressed(_ sender: Any) {
        favouritePressed?()
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.isFavourite = false
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.isFavourite = true
        }
        
    }
    
    
    func configure(element: ResultElement, isFavourite: Bool, closure: @escaping () -> ()) {
        self.isFavourite = isFavourite
        favouritePressed = closure
        let baceURL = "https://image.tmdb.org/t/p/w500"
        imageView.sd_setImage(with: .init(string: baceURL + element.posterPath)!)
        
        nameLabel.text = element.title ?? element.name
        
        dateLabel.text = element.releaseDate ?? element.firstAirDate
        
        rateLabel.text = String(Double(round(element.voteAverage * 10) / 10))
        
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
       
    }
    
    func configure(element: DataModel, isFavourite: Bool, closure: @escaping () -> ()) {
        self.isFavourite = isFavourite
        favouritePressed = closure
        let baceURL = "https://image.tmdb.org/t/p/w500"
        imageView.sd_setImage(with: .init(string: baceURL + element.posterPath)!)
        
        nameLabel.text = element.name
        
        dateLabel.text = element.firstAirDate
        
        rateLabel.text = element.voteAverage
        
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
       
    }
    
}


