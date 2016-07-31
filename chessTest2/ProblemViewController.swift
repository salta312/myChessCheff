//
//  ProblemViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

protocol ProblemVCProtocol{
    func showAlert(message:String)
}

class ProblemViewController: UIViewController, ProblemVCProtocol {
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
    func showAlert(message:String){
        let alertController=UIAlertController(title: "Check", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKButton=UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKButton)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    func setAPosition(){
        //print(index)
        let p = Problem()
        var color: UIColor!
        var initPos: Int!
        var movesMade = 0
        var myPiece: Piece!
        Board.cleanABoard()
        //print(problems.count)
        if index >= problems.count {
            return
        }
        let tempString = problems[index].composition
        let move = problems[index].move
       // let piecesArr = split(tempString){$0 == ", "}
        let piecesArr = tempString?.componentsSeparatedByString(", ")
        guard let piecesArr1 = piecesArr else{
            return
        }
        print(piecesArr1 )
        let v = MyView2()
        v.myProtocol = self
        for index in 0...piecesArr1.count-1{
            print(piecesArr1[index])
            
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
                if myPiece.color == UIColor.whiteColor() && move == "white"{
                    print("white king")
                    v.mainKing = myPiece as! King
                    print(v.mainKing.color)
                }else if myPiece.color == UIColor.blackColor() && move == "black"{
                    print("black king")
                    v.mainKing = myPiece as! King
                    print(v.mainKing.color)

                }
                
               // v.mainKing = myPiece as! King
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
                //mp.possibleMoves = mp.detectMoves()
                myPiece = mp
                
            }
            p.pieces.append(myPiece)
            if p.pieces.count - 1 >= 0{
                for index in 0...p.pieces.count - 1{
                p.pieces[index].possibleMoves = p.pieces[index].detectMoves()
                }
            }

        }
        v.problem = p
        // this is current solution not the best one I must admit
        v.problems = problems[index]
        let button: UIButton = {
            let button = UIButton()
            button.setTitle("next", forState: .Normal)
            button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
            return button
        }()
        view.addSubview(v)
        view.addSubview(button)
        constrain(view, v, button){
            view, v, button in
            v.height == view.height - 164
            v.width == view.width
            v.top == view.top + 64
            v.centerX == view.centerX
            button.top == v.bottom + 10
            button.centerX == v.centerX
            button.height == 30
            
            
        }
        
    }
    func buttonPressed(sender: UIButton){
       // print("yes you pressed me")
        //
       index += 1
       setAPosition()
        
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
