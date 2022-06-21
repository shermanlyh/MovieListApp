//
//  ViewController.swift
//  Test
//
//  Created by Shermanlyh on 16/6/2022.
//

import UIKit

class ViewController: UIViewController   {
    
    static var shared = ViewController()
    
    @IBOutlet weak var SwitchView: UIButton!
    @IBOutlet weak var CollectionView: UIView!
    @IBOutlet weak var TableView: UIView!
    
    var movieList = [MovieListElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.shared = self
        
        CollectionView.isHidden = false
        TableView.isHidden = true
       
        getJsonList()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        CollectionView.isHidden = (!CollectionView.isHidden)
        TableView.isHidden = (!TableView.isHidden)
        if TableView.isHidden == false{
            SwitchView.setImage(UIImage(systemName: "square.on.square.dashed"), for: .normal)
        }
        else{
            SwitchView.setImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .normal)
        }
    }

    func getJsonList() {
        let url = URL(string: "https://jsonkeeper.com/b/WTPZ")
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                //Parse JSON
                let decoder = JSONDecoder()
                
                do{
                    self.movieList = try decoder.decode(MovieList.self, from: data!)
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
            DispatchQueue.main.async {
                MovieCollectionViewController.shared.collectionView.reloadData()
                MovieTableViewController.shared.tableView.reloadData()
            }
        }
        //Make the API call
        dataTask.resume()
    }
}
