//
//  Animation.swift
//  issueTest
//
//  Created by AntonioStilo on 14/02/2019.
//  Copyright © 2019 com.stilo-studio. All rights reserved.
//

import UIKit

class Animation: UIView {
    
    private static let SIZE = 120.0
    private static let SPEED: CGFloat = 4.0
    private var speedX: CGFloat = 1.0
    private var speedY: CGFloat = 1.0
    
    let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Animation.SIZE, height: Animation.SIZE))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circle.roundCorners(value: CGFloat(Animation.SIZE * 0.5))
        circle.backgroundColor = getRandomColor()
        randomize()
        self.addSubview(circle)
    }
    
    func animate() {
    
        var center = circle.center
        center.x += speedX
        center.y += speedY
        if center.x <= 0.0 || center.x >= self.bounds.size.width {
            speedX *= -1
            circle.backgroundColor = getRandomColor()
        }
        if center.y <= 0.0 || center.y >= self.bounds.size.width {
            speedY *= -1
            circle.backgroundColor = getRandomColor()
        }
        circle.center = center
    }
    
    func randomize() {
        speedX = random() * Animation.SPEED
        speedY = random() * Animation.SPEED
    }
    
    private func getRandomColor () -> UIColor {
        return UIColor(red: random(), green: random(), blue: 0.7, alpha: 1.0)
    }
    
    private func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }


}
