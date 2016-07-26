//
//  MyView2.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class MyView2: UIView {
    var arr=Board.board
    var tempHeight: Int!
    var tempWidth: Int!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        //print("I was touched")
        let touch = touches.first
        guard let touch1 = touch else{
            return
        }
//        print(touch1.locationInView(self))
//        print(arr[0].x)
//        print(arr[0].y)
        if touch1.locationInView(self).x >= CGFloat(arr[0].x) && touch1.locationInView(self).x <= CGFloat(arr[0].x + 8*arr[0].width){
            if touch1.locationInView(self).y >= CGFloat(arr[0].y) && touch1.locationInView(self).y <= CGFloat(arr[0].y + 8*arr[0].height){
                    tempHeight = (Int((Float(touch1.locationInView(self).y) - arr[0].y)/arr[0].height))
                    tempWidth = (Int((Float(touch1.locationInView(self).x) - arr[0].x)/arr[0].width))
                print(tempHeight)
                print(tempWidth)
                print(tempHeight*8+tempWidth)
                
                
            }

        }
       // touches.
    }
    func findWidth(initWidth: Float!, increment: Float!){
        
    }
    func findHeight(initHeight:Float!, increment:Float!){
        
    }

    var problem: Problem!
    // var num: Int!
    func setSize(){
        // Cell.Sheight = Float(self.frame.size.height/8)
        // Cell.SWidth = Float(self.frame.size.width/8)
        //   print("I am view My size is \(self.frame.size.height)")
        //   print("I am view My size is \(self.frame.size.width)")
        
    }
    
    
    override func drawRect(rect: CGRect) {
        self.setSize()
       // let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapped"))
       // tapGesture.numberOfTapsRequired = 1
       // self.addGestureRecognizer(tapGesture)
        self.backgroundColor = UIColor.whiteColor()
        let context = UIGraphicsGetCurrentContext()

        for index in 0...arr.count-1{
            //arr[index].x
            ///var height=arr[index].height
            //let rectangle=CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].height), CGFloat(arr[index].width))
            let rectangle = CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].width), CGFloat(arr[index].height))
            CGContextAddRect(context, rectangle)
            let col=arr[index].color
            if col == UIColor.brownColor(){
                CGContextSetFillColorWithColor(context, UIColor(red: 226/255, green: 204/255, blue: 171/255, alpha: 1).CGColor)
            }else{
                CGContextSetFillColorWithColor(context, UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1).CGColor)
            }
            CGContextFillPath(context)
            
        }
        if problem != nil{
            if problem.pieces.count > 0{
                for i in 0 ... problem.pieces.count-1{
                    let piece = problem.pieces[i]
                    //  print(piece.name)
                    //  print(piece.currentPos.id)
                    _=CGSize(width: CGFloat(arr[0].width), height: CGFloat(arr[0].height))
                    let location = CGPoint(x:CGFloat(piece.currentPos.x), y: CGFloat(piece.currentPos.y))
                    piece.img.drawAtPoint(location)
                    
                }
            }
        }
        
    }
    func tapped(){
        print("I was tapped")
    }

}
