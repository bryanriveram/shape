//
//  ShapeView.swift
//  Shape
//
//  Created by Bryan Rivera on 26/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

protocol SquareViewDelegate: class{
    func ended(_ shape: ShapeView, _ bool: Bool)
}

class ShapeView: UIView {
    
    var size: CGRect!
    var position: CGPoint!
    weak var delegate: SquareViewDelegate?
    
    convenience init(size: CGRect, pos: CGPoint, bgColor: UIColor){
        self.init(frame: .zero)
        self.size = size
        self.position = pos
        self.backgroundColor = bgColor
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handle(_:)))
        self.addGestureRecognizer(gesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpress(_:)))
        self.addGestureRecognizer(longPress)
    }
    
    func handle(_ gesture: UIPanGestureRecognizer){
//        delegate?.ended(self, true)
    }
    
    func tapped(_ sender: UITapGestureRecognizer) {
//        delegate?.ended(self, false)
    }
    
    func longpress(_ sender: UILongPressGestureRecognizer){
        
    }
    
}
