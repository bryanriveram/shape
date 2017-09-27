//
//  SquareView.swift
//  Shape
//
//  Created by Bryan Rivera on 26/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

class SquareView: ShapeView {
    override func handle(_ gesture: UIPanGestureRecognizer) {
        
        self.layer.zPosition = 1
        let pointOfTouch = gesture.location(in: self.superview)
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            
//            if pointOfTouch.y <= self.superview!.frame.maxY - 100 {
                self.snp.remakeConstraints({ (make) in
                    make.size.width.equalTo(self.size.width)
                    make.size.height.equalTo(self.size.height)
                    make.centerX.equalTo(pointOfTouch.x)
                    make.centerY.equalTo(pointOfTouch.y)
                })
                
                self.setNeedsLayout()
                self.layoutIfNeeded()
                
                self.position = pointOfTouch
//            }
            break
        case .ended:
            delegate?.ended(self, true)
        default:
            break
        }
        
    }

}


