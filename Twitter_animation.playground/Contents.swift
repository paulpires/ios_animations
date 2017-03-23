import UIKit
import PlaygroundSupport
import QuartzCore

// simulating what an iPhone would look like
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

let twitterBlue = UIColor(red:0.00, green:0.67, blue:0.94, alpha:1.0)
containerView.backgroundColor = twitterBlue

let screenShotImageView = UIImageView(frame: containerView.frame)
screenShotImageView.image = UIImage(named: "twitter_home_screen")
containerView.addSubview(screenShotImageView)

// creating a mask with the twitter logo (centered on screen)
let mask = CALayer()
mask.contents = UIImage(named: "twitter_logo")?.cgImage
mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
let center = CGPoint(x: containerView.frame.size.width/2,
                     y: containerView.frame.size.height/2)
mask.position = center

// animation for expanding the twitter logo
let zoom = CAKeyframeAnimation(keyPath: "bounds")
zoom.duration = 1.5
let boundsChanges = [
    NSValue(cgRect: mask.bounds),
    NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90)),
    NSValue(cgRect: CGRect(x: 0, y: 0, width: 5000, height: 5000))
]
zoom.values = boundsChanges
zoom.keyTimes = [0, 0.7, 1]

// animation for the 'bounce' after the twitter logo has fully expanded out of view
let spring = CASpringAnimation(keyPath: "transform.scale")
spring.duration = 1
spring.damping = 20
spring.initialVelocity = 0.5
spring.fromValue = 1.10
spring.toValue = 1

screenShotImageView.layer.mask = mask
spring.beginTime = CACurrentMediaTime() + 1
mask.bounds = CGRect(x: 0, y: 0, width: 5000, height: 5000)
mask.add(zoom, forKey: "bounds")
screenShotImageView.layer.add(spring, forKey: "transform.scale")

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true
