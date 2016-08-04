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
    override func drawRect(rect: CGRect) {
       // Board.cleanABoard()
        self.backgroundColor = UIColor.clearColor()
        let context = UIGraphicsGetCurrentContext()
        var arr=Board.board
        for index in 0...arr.count-1{
            let rectangle = CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].width), CGFloat(arr[index].height))
            CGContextAddRect(context, rectangle)
            let col=arr[index].color
            if col == UIColor.brownColor(){
                CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            }else{
                 CGContextSetFillColorWithColor(context, UIColor(red: 192/255, green: 193/255, blue: 238/255, alpha: 1).CGColor)
            }
            CGContextFillPath(context)
            
        }
        if lesson != nil{
            
            if lesson.pieces.count > 0{
                for i in 0 ... lesson.pieces.count-1{
                    let piece = lesson.pieces[i]
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
