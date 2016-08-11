//  Created by Daniel Honies on 23.07.15.
//  Copyright © 2015 Daniel Honies. All rights reserved.
//

import UIKit
@IBDesignable
class RatingControl: UIView {
    // MARK: Properties
    
    @IBInspectable public var rating: Double = 0 {
        didSet {
           setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    @IBInspectable public  var spacing: Int = 5{
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var stars: Int = 5{
        didSet {
            buttonInit()
        }
    }
    @IBInspectable public var filledStarImage: UIImage? = UIImage? (){
        didSet {
            updateButtonImages()
        }
    }
    @IBInspectable public  var emptyStarImage: UIImage? = UIImage?(){
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
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        buttonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        buttonInit()
    }
    
    func buttonInit(){
        let bundle = NSBundle(forClass: RatingControl.self)
        
        if emptyStarImage == nil {
            emptyStarImage = UIImage(named: "emptyStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        }
        if filledStarImage == nil {
            filledStarImage = UIImage(named: "filledStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        }
        
        ratingButtons = [UIButton]()
        for _ in 0..<stars{
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
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


class ImageUtil: NSObject {
    
    static func cropToLength(image originalImage: UIImage, length: CGFloat) -> UIImage {
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        let contextSize: CGSize = contextImage.size
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        posX = 0
        posY = 0//((contextSize.height - contextSize.width) / 2)
        width = contextSize.width * length
        height = contextSize.height
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
}
