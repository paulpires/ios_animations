import UIKit
import PlaygroundSupport
import QuartzCore

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
let twitterBlue = UIColor(red:0.00, green:0.67, blue:0.94, alpha:1.0)
containerView.backgroundColor = twitterBlue

let screenShotImageView = UIImageView(frame: containerView.frame)
screenShotImageView.image = UIImage(named: "screenshot")
containerView.addSubview(screenShotImageView)

let mask = CALayer()
mask.contents = UIImage(named: "twitter_logo_t")?.cgImage
mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
mask.position = CGPoint(x: screenShotImageView.frame.size.width/2, y: screenShotImageView.frame.size.height/2)

screenShotImageView.layer.mask = mask

let animation = CAKeyframeAnimation(keyPath: "bounds")
animation.duration = 1.5
animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]

let boundsChanges = [
    NSValue(cgRect: mask.bounds),
    NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90)),
    NSValue(cgRect: CGRect(x: 0, y: 0, width: 5000, height: 5000))
]
animation.values = boundsChanges
animation.keyTimes = [0, 0.7, 1]

let spring = CASpringAnimation(keyPath: "transform.scale")
spring.duration = 1
spring.damping = 20
spring.initialVelocity = 0.5
spring.fromValue = 1.10
spring.toValue = 1
//spring.repeatCount = Float(INT_MAX)

animation.beginTime = 0.0
spring.beginTime = animation.duration

let group = CAAnimationGroup()
group.duration = 10
group.animations = [animation, spring]

mask.add(animation, forKey: "bounds")
mask.bounds = CGRect(x: 0, y: 0, width: 5000, height: 5000)
screenShotImageView.layer.add(spring, forKey: "transform.scale")

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

