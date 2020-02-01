//
//  SuperheroDetailsViewController.swift
//  Flix
//
//  Created by Emily Ou on 2/1/20.
//  Copyright © 2020 Emily Ou. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroDetailsViewController: UIViewController {

    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get and load title and synopsis label
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // Get the movie poster images
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        // Configure the imageView to the poster
        posterView.af_setImage(withURL: posterURL!)
        
        // Get the movie backdrop images
        let baseURL2 = "https://image.tmdb.org/t/p/w1280"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseURL2 + backdropPath)
        
        // Configure the imageView to the backdrop
        backdrop.af_setImage(withURL: backdropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
