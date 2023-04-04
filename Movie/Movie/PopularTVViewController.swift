//
//  ViewController.swift
//  Movie
//
//  Created by Alex Serhiiev on 08.03.2023.
//

import UIKit

class PopularTVViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var elements: [ResultElement] = []
    var favourites = DataService.shared.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieService.shared.getMovies(closure: { result in
            self.elements = result.results
            self.collectionView.reloadData()
        })
        
        collectionView.register(.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        favourites = DataService.shared.getData()
        collectionView.reloadData()
    }
    
    
    @IBAction func segmentControlChange(_ sender: UISegmentedControl) {
        getData()
    }
    
    func getData() {
        switch segmentControl.selectedSegmentIndex
                {
                case 0:
            MovieService.shared.getMovies(closure: { result in
                self.elements = result.results
                self.collectionView.reloadData()
            })
                    
                case 1:
            MovieService.shared.getSeries(closure: { result in
                self.elements = result.results
                self.collectionView.reloadData()
            })
                    
                default:
                    break;
                }
    }
}

extension PopularTVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let isFavourite: Bool = favourites.contains { model in
            elements[indexPath.row].id == model.id
        }
        
        cell.configure(element: elements[indexPath.row], isFavourite: isFavourite, closure: {
            let element = self.elements[indexPath.row]
            DataService.shared.saveData(data: .init(element: element))
            self.favourites = DataService.shared.getData()
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        newViewController.data = elements[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension PopularTVViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 400)
    }
}

extension PopularTVViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            getData()
        } else {
            MovieService.shared.searh(text: searchText, type: segmentControl.selectedSegmentIndex == 0 ? .movie : .tv) { result in
                self.elements = result.results
                self.collectionView.reloadData()
            }
        }
    }
}
