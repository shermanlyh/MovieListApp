//
//  MovieCollectionView.swift
//  Test
//
//  Created by Shermanlyh on 19/6/2022.
//

import UIKit

class MovieCollectionViewController: UIViewController, UICollectionViewDataSource {
    static var shared = MovieCollectionViewController()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieCollectionViewController.shared = self
        
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:  UIScreen.main.bounds.width/3,
                                 height: UIScreen.main.bounds.width/3*1.6)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return ViewController.shared.movieList.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: ViewController.shared.movieList[indexPath.row])
        print(indexPath.row , ViewController.shared.movieList[indexPath.row].name)
        return cell
    }
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_movie: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_likeCount: UILabel!
    @IBOutlet weak var label_reviewCount: UILabel!

    func setup(with movie:MovieListElement){
        label_title.text = movie.name
        label_rating.text = String(round(movie.rating * 10) / 10.0)
        label_likeCount.text = String(movie.likeCount)
        label_reviewCount.text = String(movie.reviewCount)
        label_rating.sizeToFit()
        label_likeCount.sizeToFit()
        label_reviewCount.sizeToFit()
        
        if movie.poster != "" {
            do {
                let imageURL  = URL(string: movie.poster)
                let imageData = try Data(contentsOf: imageURL!)
                let image = UIImage(data: imageData)
                image_movie.image = image
            }
            catch {
                print("CANNOT GET IMAGE",movie.name)
                image_movie.image = nil
            }
        } else {
            print("Null IMAGE URL",movie.name)
            image_movie.image = nil
        }
    }
}
