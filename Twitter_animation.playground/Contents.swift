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

//CASpringAnimation ?
class Delegate: NSObject, CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        screenShotImageView.layer.mask = nil
        screenShotImageView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 0.5, delay: 0.05, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            screenShotImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}

animation.delegate = Delegate()
screenShotImageView.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
mask.add(animation, forKey: "bounds")

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

