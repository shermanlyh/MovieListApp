//
//  MovieTableView.swift
//  Test
//
//  Created by Shermanlyh on 19/6/2022.
//

import UIKit
import Cosmos
import TinyConstraints

class MovieTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    static var shared = MovieTableViewController()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieTableViewController.shared = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.shared.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableCell
        cell.setup(with: ViewController.shared.movieList[indexPath.row])
        print(indexPath.row , ViewController.shared.movieList[indexPath.row].name)
        return cell
    }
}

class MovieTableCell: UITableViewCell{
    
    @IBOutlet weak var image_movie: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_reviewCount: UILabel!
    @IBOutlet weak var label_likeCount: UILabel!
    
    func setup(with movie:MovieListElement){
        label_title.text = movie.name
        
        let date = Date(timeIntervalSince1970: movie.openDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let movieDateString = formatter.string(from: date)
        
        label_date.text = movieDateString
        label_rating.text = String(round(movie.rating * 10) / 10.0)
        label_likeCount.text = String(movie.likeCount)
        label_reviewCount.text = String(movie.reviewCount)
        
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
        }
        else {
            print("Null IMAGE URL",movie.name)
            image_movie.image = nil
        }
    }
}
