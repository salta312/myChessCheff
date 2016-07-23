//
//  MyView1.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/13/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class MyView1: UIView {
    var lesson: Lesson!
   // var num: Int!
    func setSize(){
       // Cell.Sheight = Float(self.frame.size.height/8)
       // Cell.SWidth = Float(self.frame.size.width/8)
        print("I am view My size is \(self.frame.size.height)")
        print("I am view My size is \(self.frame.size.width)")

    }

    
    override func drawRect(rect: CGRect) {
        self.setSize()
        self.backgroundColor = UIColor.whiteColor()
        let context = UIGraphicsGetCurrentContext()
        var arr=Board.board
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
        if lesson != nil{
            if lesson.pieces.count > 0{
                for i in 0 ... lesson.pieces.count-1{
                    let piece = lesson.pieces[i]
                    print(piece.name)
                    print(piece.currentPos.id)
                    _=CGSize(width: CGFloat(arr[0].width), height: CGFloat(arr[0].height))
                    let location = CGPoint(x:CGFloat(piece.currentPos.x), y: CGFloat(piece.currentPos.y))
                    piece.img.drawAtPoint(location)
                    guard let moves = piece.possibleMoves else{
                        return
                    }
                    // need to change
                    if moves.count > 0{
                        for index in 0...moves.count-1{
                            var cells=moves[index].possibleMoves
                            if(cells.count>0){
                                for ind in 0...cells.count-1{
                                    print(cells[ind].id)
                                    // CGRectMa
                                    let rect = CGRectMake(CGFloat(cells[ind].x+arr[0].width/2), CGFloat(cells[ind].y+arr[0].height/2), CGFloat(arr[0].width/7), CGFloat(arr[0].height/7))
                                    CGContextAddRect(context, rect)
                                    CGContextSetFillColorWithColor(context, lesson.col[i].CGColor)
                                    CGContextFillPath(context)
                                    
                                }
                            }
                        }
                    }

                }
            }
        }
        
    }

}
