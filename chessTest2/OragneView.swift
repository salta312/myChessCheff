//
//  OragneView.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography


class OragneView: UIView {
    var lesson:Lesson!
    var img: UIImage!
    lazy var label: UILabel = {
        var label = UILabel()
        label.font = label.font.fontWithSize(20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "F3A017")

        //setup()
    }
    func setUp(){
        var name = lesson.text
        label.text = name
        label.textColor = UIColor.whiteColor()
        var img1 = UIImageView(image: img)
        self.addSubview(img1)
        self.addSubview(label)
        constrain(self, label, img1){
            view, label, img1 in
            label.top == view.top + 20
            label.centerX == view.centerX
            img1.top == label.bottom + 20
            img1.centerX == view.centerX
            img1.centerY == view.centerY - 50
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
