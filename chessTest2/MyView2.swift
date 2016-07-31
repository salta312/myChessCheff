//
//  MyView2.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class MyView2: UIView {
    var problems:Problems!
    var arr=Board.board
    var tempHeight: Int!
    var tempWidth: Int!
    var tempId:Int!
    var tapNumber = 0
    var moves: [Move]?
    var previousTap: Int!
    var kings:[King]!
    var mainKing:King!
    var move:String!
    var myProtocol: ProblemVCProtocol!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let touch = touches.first
        guard let touch1 = touch else{
            return
        }
        if touch1.locationInView(self).x >= CGFloat(arr[0].x) && touch1.locationInView(self).x <= CGFloat(arr[0].x + 8*arr[0].width){
            if touch1.locationInView(self).y >= CGFloat(arr[0].y) && touch1.locationInView(self).y <= CGFloat(arr[0].y + 8*arr[0].height){
                    tempHeight = (Int((Float(touch1.locationInView(self).y) - arr[0].y)/arr[0].height))
                    tempWidth = (Int((Float(touch1.locationInView(self).x) - arr[0].x)/arr[0].width))
                    tempId = tempHeight*8+tempWidth
                if mainKing.isCheck() && tempId != mainKing.currentPos{
                    myProtocol.showAlert("check")
                   // showAlert("Check")
                    return
                }
                if tempId >= 0 && tempId <= 63{
                    tapNumber += 1
                    self.setNeedsDisplay()

                }
                
                
            }

        }

       // touches.
        if mainKing.color == UIColor.whiteColor(){
            print("I am a white king")
        }else{
            print("I am a black king")
        }
    }
    
    func isPossibleMove(previousTap: Int!, tempId: Int!) ->Bool{
       // print("------------\(previousTap)------------------")
        var moves: [Move]?
        var posibleMoves = [Cell]()
        if tempId >= 0 && tempId <= 63{
            if arr[previousTap].taken != nil{
                moves = arr[previousTap].taken.possibleMoves
                guard let m = moves else{
                    return false
                }
                if m.count >= 1{
                    for index in 0...m.count - 1{
                        posibleMoves = m[index].possibleMoves
                        if posibleMoves.count - 1 >= 0{
                            for index1 in 0...posibleMoves.count - 1{
                               // print(posibleMoves[index1].id)
                                if posibleMoves[index1].id == tempId{
                                    return true
                                }
                            }
                        }
                        
                    }
                }
            }
            
            
            
        }
            return false
        
    }


    var problem: Problem!
    // var num: Int!
    func setSize(){
        // Cell.Sheight = Float(self.frame.size.height/8)
        // Cell.SWidth = Float(self.frame.size.width/8)
        
    }
    
    
    override func drawRect(rect: CGRect) {
        self.setSize()
        print(mainKing)
       // let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapped"))
       // tapGesture.numberOfTapsRequired = 1
       // self.addGestureRecognizer(tapGesture)
        self.backgroundColor = UIColor.whiteColor()
        let context = UIGraphicsGetCurrentContext()

        for index in 0...arr.count-1{
            //arr[index].x
            ///var height=arr[index].height
            //let rectangle=CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].height), CGFloat(arr[index].width))
       //     if tempId == nil || tempId != index{
                let rectangle = CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].width), CGFloat(arr[index].height))
                CGContextAddRect(context, rectangle)
                let col=arr[index].color

               if col == UIColor.brownColor(){
                    CGContextSetFillColorWithColor(context, UIColor(red: 226/255, green: 204/255, blue: 171/255, alpha: 1).CGColor)
               // CGContextFillPath(context)

                }else{
                    CGContextSetFillColorWithColor(context, UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1).CGColor)
               // CGContextFillPath(context)

                }
            

            if tapNumber == 1{
            
                if tempId != nil && tempId == index{
                    if arr[index].taken != nil{
               // if tempId != nil && arr[tempId].taken != nil{
                        //commenting out temporary to see

                    if (problems.move == "white" && arr[index].taken.color == UIColor.whiteColor()) || (problems.move == "black" && arr[index].taken.color == UIColor.blackColor()){
                        previousTap = index
                    
                        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
                        CGContextFillPath(context)
                        // till here

                    }
                    //add a line of code when the user chose an empty cell
//                    }else{
//                        tapNumber = 0
//                    }
                    }else{
                        previousTap = nil
                        tapNumber = 0
                    }
                }
            }else if tapNumber >= 2{
                tapNumber = 0
                if tempId != nil && previousTap != nil{
                    if self.isPossibleMove(previousTap, tempId: tempId){
                       // var p = arr[previousTap].taken.currentPos = arr[tempId]
                        if arr[tempId].taken != nil{
                            //takes everything appart from king
                            if arr[previousTap].taken.color != arr[tempId].taken.color && arr[tempId].taken.name != Pieces.king{
                                let p = arr[previousTap].taken
                               // let prev = arr[tempId].taken
                                p.currentPos = arr[tempId]
                                arr[previousTap].taken = nil
                                arr[tempId].taken = nil
                                arr[tempId].taken = p
                                p.possibleMoves = p.detectMoves()
                                
                                
                                
                                
                            }
                            
                        }else{
                            let p = arr[previousTap].taken
                            p.currentPos = arr[tempId]
                            arr[tempId].taken = p
                            arr[previousTap].taken = nil
                            p.possibleMoves = p.detectMoves()
                            previousTap = tempId
                        }
                        
                    }else{
                        //print("previousTap= \(previousTap) tempId = \(tempId)")
                        print("no")
                    }
                }
                
            }
            //till here
            CGContextFillPath(context)

            if arr[index].taken != nil{
                let p1 = arr[index].taken
                _=CGSize(width: CGFloat(arr[0].width), height: CGFloat(arr[0].height))
                let location = CGPoint(x:CGFloat(p1.currentPos.x), y: CGFloat(p1.currentPos.y))
                p1.img.drawAtPoint(location)
              //  CGContextFillPath(context)
                 CGContextFillPath(context)
                
                //print()
            }
           //     CGContextFillPath(context)
               
         //   }


            
        }
//        if problem != nil{
//            if problem.pieces.count > 0{
//                for i in 0 ... problem.pieces.count-1{
//                    let piece = problem.pieces[i]
//                    _=CGSize(width: CGFloat(arr[0].width), height: CGFloat(arr[0].height))
//                    let location = CGPoint(x:CGFloat(piece.currentPos.x), y: CGFloat(piece.currentPos.y))
//                    piece.img.drawAtPoint(location)
//                    
//                }
//            }
//        }
        
    }

}
