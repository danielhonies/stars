//
//  ViewController.swift
//  RatingSystem
//
//  Created by Daniel Honies on 27.07.15.
//  Copyright © 2015 Daniel Honies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var filledStarImage = UIImage (named: "star10")
    var emptyStarImage = UIImage(named: "star30")
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        //RatingSystem with Standard Star Images with User Input and Standard values
        
        let frameLabel = CGRect(x: 0, y: 50, width: 1000, height: 30)
        let label: UILabel = UILabel(frame: frameLabel)
        label.text = "User Input enabled and Standard Values"
        self.view.addSubview(label)
        
        let frameRating = CGRect(x:0, y: 100, width: 600, height: 50)
        let rating = RatingControl(frame: frameRating)
        self.view.addSubview(rating)
        self.view.addSubview(label)
        
        //RatingSystem with UserInput enabled and custom Star Images
        let frameLabel1 = CGRect(x: 0, y: 160, width: 2000, height: 20)
        let label1: UILabel = UILabel(frame: frameLabel1)
        label1.text = "Input enabled, & Custom Values & Stars"
        self.view.addSubview(label1)
        
        let frameRating1 = CGRect(x:0, y: 200, width: 600, height: 50)
        let rating1 = RatingControl(frame: frameRating1, rating: 2.7, spacing: 5, stars: 5)
        rating1.filledStarImage = filledStarImage
        rating1.emptyStarImage = emptyStarImage
        self.view.addSubview(rating1)
        
        //RatingSystem with UserInput disabled
        let frameLabel2 = CGRect(x: 0, y: 260, width: 1000, height: 30)
        let label2: UILabel = UILabel(frame: frameLabel2)
        label2.text = "User Input disabled"
        self.view.addSubview(label2)
        
        let frameRating2 = CGRect(x:0, y: 300, width: 600, height: 50)
        let rating2 = RatingControl(frame: frameRating2, rating: 3.25, spacing: 5, stars: 5)
        rating2.userInteractionEnabled = false
        self.view.addSubview(rating2)
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

