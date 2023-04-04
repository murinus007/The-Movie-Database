//
//  FavouritesViewController.swift
//  Movie
//
//  Created by Alex Serhiiev on 08.03.2023.
//

import Foundation
import UIKit


class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var elements: [DataModel] = []
    var favourites = DataService.shared.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elements = DataService.shared.getData()
        collectionView.reloadData()
        
        collectionView.register(.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        elements = DataService.shared.getData()
        collectionView.reloadData()
    }
    
    
}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(element: elements[indexPath.row], isFavourite: true, closure: {
            let element = self.elements[indexPath.row]
            DataService.shared.saveData(data: self.elements[indexPath.row])
            self.elements = DataService.shared.getData()
            collectionView.reloadData()
            
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 400)
    }
}
