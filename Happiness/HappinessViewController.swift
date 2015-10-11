//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Taku Fukushima on 7/19/15.
//  Copyright (c) 2015 Taku Fukushima. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHapiness:"))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHapiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            happiness += happinessChange
            gesture.setTranslation(CGPointZero, inView: faceView)
        default: break
        }
    }
    
    var happiness: Int = 100 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
