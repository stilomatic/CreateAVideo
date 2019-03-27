//
//  Activity.swift
//  BrandyMelville
//
//  Created by AntonioStilo on 08/03/2018.
//  Copyright © 2018 galtone. All rights reserved.
//

import UIKit

class Activity: UIView {
    
    private var label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 160.0,height: 44.0))
    private var activity = UIImageView(frame: CGRect(x:0,y:0,width:120,height:120))
    private var view: UIView!
    
    init(rootView: UIView? = nil) {
        
        view = rootView == nil ? UIApplication.shared.delegate?.window??.rootViewController?.view : rootView!
        super.init(frame: view.bounds)
        clipsToBounds = true
        backgroundColor = UIColor.init(white: 1.0, alpha: 0.85)
        alpha = 0.0
        view.addSubview(self)
        
        activity.animationImages = composeAnimation()
        activity.animationDuration = 0.7
        activity.animationRepeatCount = 1000
        addSubview(activity)
        activity.center = CGPoint(x: center.x, y: center.y - 60)
        activity.startAnimating()
        
        label.backgroundColor = UIColor.clear
        label.text = "... RENDERING ..."
        label.textColor = UIColor.black
        label.textAlignment = .center
        addSubview(label)
        label.center = CGPoint(x: center.x, y: center.y + 24)
        open()
        
    }
    
    private func composeAnimation() -> [UIImage] {
        
        return [UIImage(named: "frame-0")!,
                UIImage(named: "frame-1")!,
                UIImage(named: "frame-2")!,
                UIImage(named: "frame-3")!,
                UIImage(named: "frame-4")!,
                UIImage(named: "frame-5")!,
                UIImage(named: "frame-6")!,
                UIImage(named: "frame-7")!,
                UIImage(named: "frame-8")!,
                UIImage(named: "frame-9")!,
                UIImage(named: "frame-10")!,
                UIImage(named: "frame-11")!,
                UIImage(named: "frame-12")!,
                UIImage(named: "frame-13")!,
                UIImage(named: "frame-14")!,
                UIImage(named: "frame-15")!,
                UIImage(named: "frame-16")!,
                UIImage(named: "frame-17")!,
                UIImage(named: "frame-18")!,
                UIImage(named: "frame-19")!,
                UIImage(named: "frame-20")!,
                UIImage(named: "frame-21")!,
                UIImage(named: "frame-22")!,
                UIImage(named: "frame-23")!,
                UIImage(named: "frame-24")!,
                UIImage(named: "frame-25")!,
                UIImage(named: "frame-26")!,
                UIImage(named: "frame-27")!,
                UIImage(named: "frame-28")!,
                UIImage(named: "frame-29")!]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func open(){
        
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }) { success in
        }
        
    }
    
    public func close(){
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }) { success in
            self.view.isUserInteractionEnabled = true
            self.removeFromSuperview()
        }
        
    }
    
}
