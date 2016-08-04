//
//  ProblemViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography
import ENSwiftSideMenu

class ProblemViewController: UIViewController, ProblemVCProtocol {
    var board = Board.board
    var problems: [Problems]!
    var index = 0
    var noteIndex = 0
    private lazy var view2: MyView2 = {
        let v = MyView2()
        v.myProtocol = self
        return v
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("next", forState: .Normal)
        button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        return button
    }()
    private lazy var moveLabel:UILabel = {
        let label = UILabel()
      //  label.text = problems[index].move
     //   label.text = self.problems[index].move
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1/255, green: 152/255, blue: 215/255, alpha: 1)
        navigationItem.title = "Задачи"
        self.view.backgroundColor = UIColor(hexString: "FFFAC3")
        
        Board.cleanABoard()
        setAPosition(0)
        moveLabel.textColor = UIColor.whiteColor()
        moveLabel.text = problems[index].move
        
        print(problems[index].move)
        
        [view2, button, moveLabel].forEach { self.view.addSubview($0) }
        
        constrain(view, view2, button, moveLabel){
            view, v, button, label in
            v.height == CGFloat(Cell.Sheight*8)
            v.width == CGFloat(Cell.SWidth*8)
            v.top == view.top + 84
            v.centerX == view.centerX
            label.top == v.bottom + 10
            label.centerX == v.centerX
            button.top == label.bottom + 10
            button.centerX == v.centerX
            button.height == 30
        }
    }
    
    func setAPosition(index: Int) {
        if index >= problems.count { return }
        
        Board.cleanABoard()
        let p = Problem()
        var color: UIColor!
        var initPos: Int!
        var movesMade = 0
        var myPiece: Piece!

        let composition = problems[index].composition
        let move = problems[index].move
        let note = problems[index].note
        var noteArr = note?.componentsSeparatedByString(", ")
        guard let myNoteArr = noteArr else{
            return
        }

        guard let pieces = composition?.componentsSeparatedByString(", ")
            else { return }
        
        pieces.forEach { piece in
            let onePiece = piece.componentsSeparatedByString(" ")
            
            guard let firstPiece = onePiece.first,
                col = firstPiece.characters.last
                else { return }
            
            
            let piece = firstPiece.substringToIndex(firstPiece.endIndex.predecessor())
            
            if piece == "King" {
                color = col == "1" ? .whiteColor() : .blackColor()
                initPos = col == "1" ? 60 : 4
                if color == UIColor.whiteColor(){
                    if noteIndex != 0{
                        noteIndex = 0
                    }
                }
                movesMade = Int(myNoteArr[noteIndex])!

                //if initPos != Int(firstPiece) { movesMade = 1 }
                
                myPiece = King(color: color, initPos: board[initPos],
                    currentPos: board[Int(onePiece[1])!], movesMade: movesMade)
                //print("I am king \(movesMade)")
                //print(" and \(noteIndex)")
                noteIndex += 1
                
                if myPiece.color == UIColor.whiteColor() && move == "white" {
                    view2.mainKing = myPiece as! King
                } else if myPiece.color == UIColor.blackColor() && move == "black"{
                    view2.mainKing = myPiece as! King
                }
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
                //forced unwrapping!!!
                movesMade = Int(myNoteArr[noteIndex])!
                //print("I am rock \(movesMade)")
               // print("and \(noteIndex)")
                noteIndex = noteIndex + 1
                if movesMade == 0 {
                    initPos = board[Int(onePiece[1])!].id
                }
                myPiece = Rock(color: color, initPos: board[initPos], currentPos: board[Int(onePiece[1])!], movesMade: movesMade)


            }else if piece == "P"{
                if col == "1"{
                    color = UIColor.whiteColor()
                 //   initPos = 0
                }else{
                    color = UIColor.blackColor()
                   // initPos = 56
                }
                let mp = Pone(color: color, currentPos: board[Int(onePiece[1])!])
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
        
        view2.problem = p
        view2.problems = problems[index]
        
        view2.setNeedsDisplay()
    }
    
    func buttonPressed(sender: UIButton) {
        //if index + 1 < problems.count{
            index += 1
            setAPosition(index)
        //}else{
        //    print("It is maximum")
       // }
    }

    func barButtonItemClicked(button: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    func answerUpdated(answer: String) {
        view2.checkTheAnswer(answer)
    }
}
