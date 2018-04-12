//
//  ViewController.swift
//  UIDynamicTest
//
//  Created by Yu-J.Cheng on 2018/4/12.
//  Copyright © 2018年 YuChienCheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIImageView!
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create an instance of UIDynamicAnimator, which requires you pass the reference view that will hold all behaviours and animations. This is most likely the root view of the view controller, since all UIDynamicItem views must be a subview of the reference view.
        animator = UIDynamicAnimator(referenceView: view)
        // Create an instance of UISnapBehavior, pass our cardView and the position on the screen we want it to snap to.
        snapping = UISnapBehavior(item: cardView, snapTo: view.center)
        animator.addBehavior(snapping)

        cardView.image = UIImage(named: "cat")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        cardView.addGestureRecognizer(panGesture)
        cardView.isUserInteractionEnabled = true
    }

    /// move view to where panGesture ended
    @objc func pannedView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // when beginning remove Behavior
            animator.removeBehavior(snapping)
        case .changed:
            // A point identifying the new location of a view in the coordinate system of its designated superview.
            let transation = recognizer.translation(in: view)
            // get original location of cardView and add transtion value
            cardView.center = CGPoint(x: cardView.center.x + transation.x, y: cardView.center.y + transation.y)
            // Changing the translation value resets the velocity of the pan.
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            // the end add behavior
            animator.addBehavior(snapping)
        default:
            break
        }

    }
}

