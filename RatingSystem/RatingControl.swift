//  Created by Daniel Honies on 23.07.15.
//  Copyright © 2015 Daniel Honies. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    
    var rating: Double = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    var spacing = 5{
        didSet {
            setNeedsLayout()
        }
    }
    var stars = 5{
        didSet {
            buttonInit()
        }
    }
    var filledStarImage = UIImage (named: "filledStar"){
        didSet {
            updateButtonImages()
        }
    }
    var emptyStarImage = UIImage(named: "emptyStar"){
        didSet {
            updateButtonImages()
        }
    }
    var splitButton = UIButton()
  // MARK: Initialization
      required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.filledStarImage = UIImage(named: "filledStar")
        self.emptyStarImage = UIImage(named: "emptyStar")
        buttonInit()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        buttonInit()
    }
    
    convenience init( frame: CGRect, rating: Double, spacing: Int, stars: Int) {
        self.init(frame: frame)
        self.spacing = spacing
        self.stars = stars
        self.rating = rating
        buttonInit()
        
    }
    
    func buttonInit(){
        ratingButtons = [UIButton]()
        for _ in 0..<stars{
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
            
        }
        updateButtonSelectionStates()
    }

    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        self.splitButton.removeFromSuperview()
        rating = Double(ratingButtons.indexOf(button)!) + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            let dindex: Double = Double(index)
            if ((rating-dindex)>=1){
                button.selected = dindex < rating
            }
            else if((rating-dindex)<1)&&(rating-dindex)>0 && !splitButton.isDescendantOfView(self){
                button.selected = false
                splitButton = UIButton()
                splitButton.selected = true
                let length: CGFloat = CGFloat(rating-dindex)
                splitButton.setImage(ImageUtil.cropToLength(image: filledStarImage!, length:length), forState: .Selected)
                let buttonSize = Int(frame.size.height)
                var splitButtonFrame = CGRect(x: 0, y: 0, width: CGFloat(buttonSize) * length, height: CGFloat(buttonSize))
                splitButtonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
                splitButton.frame = splitButtonFrame
                
                self.addSubview(splitButton)
            }
            else{
                button.selected = false
            }
            
        }
    }
    
    func updateButtonImages(){
        for button in ratingButtons{
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
        }
    }
}
