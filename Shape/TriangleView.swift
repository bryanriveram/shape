//
//  TriangleView.swift
//  Shape
//
//  Created by Bryan Rivera on 26/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

class TriangleView: ShapeView {
    

    override func handle(_ gesture: UIPanGestureRecognizer) {
        
        self.layer.zPosition = 1
        let pointOfTouch = gesture.location(in: self.superview)
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            if pointOfTouch.y <= self.superview!.frame.maxY - 120 {
                self.snp.remakeConstraints({ (make) in
                    make.width.equalTo(self.size.width)
                    make.height.equalTo(self.size.height)
                    make.centerX.equalTo((superview?.center)!)
                    make.centerY.equalTo(pointOfTouch.y)
                })
            
                self.setNeedsLayout()
                self.layoutIfNeeded()
                self.position = pointOfTouch
            }
            break
        case .ended:
            break
        default:
            break
        }
        
    }
    
    override func longpress(_ sender: UILongPressGestureRecognizer) {
        delegate?.ended(self, false)
    }

}
