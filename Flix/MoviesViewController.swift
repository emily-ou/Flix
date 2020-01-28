//
//  MoviesViewController.swift
//  Flix
//
//  Created by Emily Ou on 1/22/20.
//  Copyright © 2020 Emily Ou. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Returns reusable tableView cell - dequeues existing cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // Get movie and its title for each cell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        // Configure labels text accordingly
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        // Get the movie poster images
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)!
        
        // Configure the imageView to the poster
        cell.posterView.af_setImage(withURL: posterURL)
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    // Create an array of dictionaries
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // API URL, load request, create a session, create a tasks
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // This will run when the network request returns
            // Parse data or throw error
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                // Access dictionary and cast as array of dictionaries
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // Reload tableView data
                self.tableView.reloadData()
           }
        }
        task.resume()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
    
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        // Deselect cell after selection
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
