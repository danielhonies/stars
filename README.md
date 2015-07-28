# Stars, fully configurable Rating Control 
Lightweight Rating Control for Stars &amp; Symbols written in Swift 2.0 for iOS
With stars you can easily add a Star(or any other Symbol you need) Rating Control to your Project.
It includes a demo iOS App which shows the different modes and settings.
Stars is similar to Rating Controls used at Amazon or in the App Store

What you can do with stars:

* Display any Rating full or precise 
* Add Standard Control Interface directly from Storyboard
* Get User Input Rating
* Stars can display any Rating and comes with two different sets of Stars
* Can display a precise rating with any symbol graphic , you just need to provide an full-filled and a non-filled version of it 

See the [screenshot.png](https://github.com/danielhonies/stars/blob/master/screenshot.png) for some examples !
## Setup

Just add [RatingControl.swift](https://github.com/danielhonies/stars/blob/master/RatingSystem/RatingControl.swift) and [ImageUtil.swift](https://github.com/danielhonies/stars/blob/master/RatingSystem/ImageUtil.swift) to your xCode Project

## Usage and Customization

You can customize the Rating Control either by creating an outlet if you are creating the view in your storyboard

```Swift
@IBOutlet weak var ratingControl: RatingControl!
ratingControl.rating = 3.25
ratingControl.stars = 5
ratingControl.spacing = 5
ratingControl.filledStarImage = UIImage(named: "SampleName")
ratingControl.emptyStarImage = UIImage(named: "SampleName")
```
If you are not using the storyboard to align the view, just use one of the two initializers to create a new instance

```Swift
init(frame: CGRect)
init( frame: CGRect, rating: Double, spacing: Int, stars: Int)
```
## License
stars is released under the MIT License. See the License File!


