//
//  ViewController.swift
//  Shape
//
//  Created by Bryan Rivera on 26/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    let bin: UIImageView = UIImageView(image: UIImage(named: "bin"))
    // create popup UIView
    let popup = UIView(frame: .zero)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add New Shape button
        let addButton = UIButton(frame: .zero)
        addButton.backgroundColor = UIColor.green
        addButton.setTitle("Add Shape", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.addTarget(self, action: #selector(openPopup), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints{(make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-10)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.height.equalTo(50)
        }
        
        // init popup
        self.popup.frame.size.width = 400
        self.popup.frame.size.height = 190
        self.popup.backgroundColor = UIColor.gray
        self.popup.alpha = 1
        self.popup.layer.zPosition = 100
        self.popup.isHidden = true
        self.view.addSubview(popup)
        self.popup.snp.makeConstraints{(make) in
            make.width.equalTo(300)
            make.height.equalTo(190)
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        
        // button for square
        let buttonSquare = UIButton(frame: .zero)
        buttonSquare.setTitle("Add Square", for: .normal)
        buttonSquare.backgroundColor = UIColor.blue
        buttonSquare.setTitleColor(UIColor.white, for: .normal)
        buttonSquare.addTarget(self, action: #selector(addSquare), for: .touchUpInside)
        
        self.popup.addSubview(buttonSquare)
        
        buttonSquare.snp.makeConstraints{(make) in
            make.top.equalTo(self.popup.snp.top).offset(10)
            make.left.equalTo(self.popup.snp.left).offset(10)
            make.right.equalTo(self.popup.snp.right).offset(-10)
            make.height.equalTo(50)
        }
        
        // button for circle
        let buttonCircle = UIButton(frame: .zero)
        buttonCircle.setTitle("Add Circle", for: .normal)
        buttonCircle.backgroundColor = UIColor.red
        buttonCircle.setTitleColor(UIColor.white, for: .normal)
        buttonCircle.addTarget(self, action: #selector(addCircle), for: .touchUpInside)
        
        self.popup.addSubview(buttonCircle)
        
        buttonCircle.snp.makeConstraints{(make) in
            make.top.equalTo(buttonSquare.snp.top).offset(60)
            make.left.equalTo(self.popup.snp.left).offset(10)
            make.right.equalTo(self.popup.snp.right).offset(-10)
            make.height.equalTo(50)
        }
        
        // button for triangle
        let buttonTriangle = UIButton(frame: .zero)
        buttonTriangle.setTitle("Add Rectangle", for: .normal)
        buttonTriangle.backgroundColor = UIColor.yellow
        buttonTriangle.setTitleColor(UIColor.white, for: .normal)
        buttonTriangle.addTarget(self, action: #selector(addTriangle), for: .touchUpInside)
        
        self.popup.addSubview(buttonTriangle)
        
        buttonTriangle.snp.makeConstraints{(make) in
            make.top.equalTo(buttonSquare.snp.top).offset(120)
            make.left.equalTo(self.popup.snp.left).offset(10)
            make.right.equalTo(self.popup.snp.right).offset(-10)
            make.height.equalTo(50)
        }
        
        // init bin
        self.view.addSubview(bin)
        bin.snp.makeConstraints{ (make) in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-60)
            make.width.equalTo(100)
            make.height.equalTo(110)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPopup(){
        self.popup.isHidden = false
    }
    
    func addSquare(){
        // Add Sqaure to storyboard
        self.popup.isHidden = true
        let square = SquareView(size: CGRect(x:0, y:0, width: 100, height:100), pos: self.view.center, bgColor: .blue)
        square.layer.zPosition = 1
        self.view.addSubview(square)
        square.snp.makeConstraints {(make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        square.delegate = self
    }
    
    func addCircle(){
        // Add Circle to storyboard
        self.popup.isHidden = true
        let circle = CircleView(size: CGRect(x:0, y:0, width: 100, height:100), pos: self.view.center, bgColor: .red)
        circle.layer.zPosition = 1
        circle.layer.cornerRadius =  50
        self.view.addSubview(circle)
        circle.snp.makeConstraints {(make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        circle.delegate = self
    }
    
    func addTriangle(){
        self.popup.isHidden = true
        let triangle = TriangleView(size: CGRect(x:50, y:50, width: 200, height:100), pos: self.view.center, bgColor: .yellow)
        triangle.layer.zPosition = 1
        self.view.addSubview(triangle)
        triangle.snp.makeConstraints {(make) in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        triangle.delegate = self
    }
}


extension ViewController: SquareViewDelegate {
    func ended(_ shape: ShapeView, _ bool: Bool) {
        let intersect = self.bin.frame.intersects(shape.frame)
        if intersect && bool{
            shape.removeFromSuperview()
        } else if bool==false{
            shape.removeFromSuperview()
        }
    }
}

class Custom: UIView {
    override func draw(_ rect: CGRect) {
        let path = trainglePathWithCenter(center: self.center, side: self.bounds.width / 2)
        
        path.stroke()
    }
    
    func trainglePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX, y: startY + side))
        path.addLine(to: CGPoint(x: startX + side, y: startY + side/2))
        path.close()
        
        return path
    }
}
