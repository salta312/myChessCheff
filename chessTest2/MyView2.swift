//
//  MyView2.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

protocol ProblemVCProtocol {
    func showAlert(message:String)
    func setAPosition(index: Int)
    func answerUpdated(answer: String)
}

extension ProblemVCProtocol where Self: UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Check", message: message,
                                                preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

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
    var answ:String! {
        didSet {
            myProtocol.answerUpdated(answ)
        }
    }
    var tempClr:String!
    var probIndex: Int = 0
    
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
                
                if mainKing.isCheck() && tempId != mainKing.currentPos {
                    myProtocol.showAlert("check")
                } else if tempId >= 0 && tempId <= 63{
                    tapNumber += 1
                    setNeedsDisplay()
                }
            }

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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        backgroundColor = UIColor.blackColor()
        let context = UIGraphicsGetCurrentContext()

        for index in 0...arr.count-1{
            let rectangle = CGRectMake(CGFloat(arr[index].x), CGFloat(arr[index].y), CGFloat(arr[index].width), CGFloat(arr[index].height))
            CGContextAddRect(context, rectangle)
            let col = arr[index].color

            col == UIColor.brownColor()
                ? CGContextSetFillColorWithColor(context, UIColor(red: 226/255, green: 204/255, blue: 171/255, alpha: 1).CGColor)
                : CGContextSetFillColorWithColor(context, UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1).CGColor)
            if tapNumber == 1 {
                if tempId != nil && tempId == index{
                    if arr[index].taken != nil{
                        if (problems.move == "white" && arr[index].taken.color == UIColor.whiteColor()) || (problems.move == "black" && arr[index].taken.color == UIColor.blackColor()){
                            previousTap = index
                    
                            CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
                            CGContextFillPath(context)
                        }
                    } else {
                        previousTap = nil
                        tapNumber = 0
                    }
                }
            } else if tapNumber >= 2 {
                tapNumber = 0
                if tempId != nil && previousTap != nil{
                    if self.isPossibleMove(previousTap, tempId: tempId) {
                        if arr[tempId].taken != nil{
                            if arr[previousTap].taken.color != arr[tempId].taken.color && arr[tempId].taken.name != Pieces.king {
                                let p = arr[previousTap].taken
                               // let prev = arr[tempId].taken
                                p.currentPos = arr[tempId]
                                arr[previousTap].taken = nil
                                arr[tempId].taken = nil
                                arr[tempId].taken = p
                                p.possibleMoves = p.detectMoves()
                                CGContextFillPath(context)

                                tempClr = problems.move == "white" ? "1" : "2"
                                answ = p.name.rawValue + tempClr + " " + String(tempId)
                            }
                        } else {
                            let p = arr[previousTap].taken
                            p.currentPos = arr[tempId]
                            arr[tempId].taken = p
                            arr[previousTap].taken = nil
                            p.possibleMoves = p.detectMoves()
                            previousTap = tempId
                            CGContextFillPath(context)
                            
                            tempClr = problems.move == "white" ? "1" : "2"
                            answ = p.name.rawValue + tempClr + " " + String(tempId)
                        }
                    } else {
                        print("no")
                    }
                }
            }

            CGContextFillPath(context)

            if arr[index].taken != nil {
                let p1 = arr[index].taken
                let location = CGPoint(x: CGFloat(p1.currentPos.x), y: CGFloat(p1.currentPos.y))
                p1.img.drawAtPoint(location)
                CGContextFillPath(context)
            }
        }
    }
    
    func checkTheAnswer(answer: String) {
        if answer == problems.answer {
            myProtocol.showAlert("Correct")
            probIndex += 1
            myProtocol.setAPosition(probIndex)
        } else {
            myProtocol.showAlert("You are wrong try again")
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(
                1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.myProtocol.setAPosition(self.probIndex)
            }
        }
    }
}
