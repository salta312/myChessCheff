//
//  GreenView.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class GreenView: UIView {
    var lesson:Lesson!
    var img: UIImage!
    var viewHeight:Float!
    var viewWidth:Float!
    var imgForKing:UIImage!
    lazy var label: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "7ED321")
        
        //setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var tempIndex = Float(0)
    func setUP(){
        
        if lesson != nil && lesson.pieces[0].name != Pieces.king{
            var distance = Float(0)
            if lesson.pieces[0].weight == 9{
                distance = Float(0)
            }
            else  if lesson.pieces[0].weight == 5{
                distance = 30
            } else if lesson.pieces[0].weight == 3{
                distance = 70
            }else{
                distance = viewHeight/2 - 30
            }
            for index in 0...lesson.pieces[0].weight-1{
                print("I am here")
                tempIndex = tempIndex + distance
                if index != 0{
                    tempIndex = tempIndex + Float(img.size.height)
                }
                var imgView = UIImageView(image: img)
                imgView.frame = CGRect(x: CGFloat(100), y: CGFloat(tempIndex), width: img.size.width, height: img.size.height)
                self.addSubview(imgView)
                
            }
            
        }else if lesson.pieces[0].name == Pieces.king{
            var distance = viewHeight/2 - 30
            tempIndex = tempIndex + distance
            var imgView = UIImageView(image: imgForKing)
            imgView.frame = CGRect(x: CGFloat(100), y: CGFloat(tempIndex), width: imgForKing.size.width, height: imgForKing.size.height)
            self.addSubview(imgView)
        }
    }

}
