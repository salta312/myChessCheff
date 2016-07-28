//
//  ProblemViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class ProblemViewController: UIViewController {
    var board = Board.board
    var problems: [Problems]!
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.redColor()
        Board.cleanABoard()
        //add shuffle
        setAPosition()
        
        

        // Do any additional setup after loading the view.
    }
    func setAPosition(){
        let p = Problem()
        var color: UIColor!
        var initPos: Int!
        var movesMade = 0
        var myPiece: Piece!
        Board.cleanABoard()
        if index >= problems.count {
            return
        }
        let tempString = problems[index].composition
       // let piecesArr = split(tempString){$0 == ", "}
        let piecesArr = tempString?.componentsSeparatedByString(", ")
        guard let piecesArr1 = piecesArr else{
            return
        }
        for index in 0...piecesArr1.count-1{
            //print(piecesArr1[index])
            let onePiece = piecesArr1[index].componentsSeparatedByString(" ")
            guard let col = onePiece[0].characters.last else{
                return
            }

            let piece = onePiece[0].substringToIndex(onePiece[0].endIndex.predecessor())
            if piece == "King"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 60
                }else{
                    color = UIColor.blackColor()
                    initPos = 4
                }
                //let currentPos = onePiece[1]
                
//                guard let curretPos = onePiece[1] else{
//                    return
//                }
                // not quit correct because I am comparing currentPos and initPos need to change
                if initPos != Int(onePiece[1]){
                    movesMade = 1
                }
                
                 myPiece = King(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!], movesMade: movesMade)
               // p.pieces.append(myPiece)
            }else if piece == "Q"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 3
                }else{
                    color = UIColor.blackColor()
                    initPos = 59
                }
                myPiece = Queen(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!])
                
            }else if piece == "K"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 1
                }else{
                    color = UIColor.blackColor()
                    initPos = 57
                }
                myPiece = Knight(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!])
                
            }else if piece == "B"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 1
                }else{
                    color = UIColor.blackColor()
                    initPos = 57
                }
                myPiece = Bishop(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!])
                
            }else if piece == "R"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 0
                }else{
                    color = UIColor.blackColor()
                    initPos = 56
                }
                myPiece = Rock(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!])
            }else if piece == "P"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 0
                }else{
                    color = UIColor.blackColor()
                    initPos = 56
                }
                let mp = Pone(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!])
                mp.possibleMoves = mp.detectMoves()
                myPiece = mp
                
            }
            p.pieces.append(myPiece)
            let v = MyView2()
            v.problem = p
            // this is current solution not the best one I must admit
            v.problems = problems[0]
            view.addSubview(v)
            constrain(view, v){
                view, v in
                v.height == view.height - 64
                v.width == view.width
                v.top == view.top + 64
                v.centerX == view.centerX
            }
            
            
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
