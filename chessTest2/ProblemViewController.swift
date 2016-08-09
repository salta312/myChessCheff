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
        button.backgroundColor = UIColor.whiteColor()
        //button.setTitle("next", forState: .Normal)
        button.setImage(UIImage(named:"next"), forState: .Normal)
        button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        return button
    }()
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        //button.setTitle("next", forState: .Normal)
        button.setImage(UIImage(named:"icon"), forState: .Normal)
        button.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
        return button
    }()
    private lazy var moveLabel:UILabel = {
        let label = UILabel()
      //  label.text = problems[index].move
     //   label.text = self.problems[index].move
        return label
        
    }()
    func goBack(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button.layer.cornerRadius = button.bounds.size.height / 2
        button2.layer.cornerRadius = button.bounds.size.height / 2
        //button3.layer.cornerRadius = button2.bounds.size.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1/255, green: 152/255, blue: 215/255, alpha: 1)
        navigationItem.title = "Задачи"
        self.view.backgroundColor = UIColor(hexString: "FEE3C7")
        
        Board.cleanABoard()
        setAPosition(0)
        moveLabel.textColor = UIColor.blackColor()
        
        if problems[index].move == "white"{
            moveLabel.text = "Ход белых"
        }else{
            moveLabel.text = "Ход черных"
        }
        
       // print(problems[index].move)
        
        [view2, button, moveLabel, button2].forEach { self.view.addSubview($0) }
        
        constrain(view, view2, moveLabel, button, button2){
            view, v, label, button, button2 in
            v.height == CGFloat(Cell.Sheight*8)
            v.width == CGFloat(Cell.SWidth*8)
            v.top == view.top + 84
            v.centerX == view.centerX
            label.top == v.bottom + 10
            label.centerX == view.centerX
            button2.bottom == view.bottom - 20
            button2.centerX == view.centerX - 100
            button2.height == CGFloat(50)
            button2.width == CGFloat(50)
            button.bottom == view.bottom - 20
            button.centerX == view.centerX + 100
            button.height == CGFloat(50)
            button.width == CGFloat(50)
        }
    }

    
    func setAPosition(index: Int) {
        if index >= problems.count || index < 0 { return }
        
        Board.cleanABoard()
        let p = Problem()
        var color: UIColor!
        var initPos: Int!
        var movesMade = 0
        var myPiece: Piece!
        self.index = index

        let composition = problems[index].composition
        let move = problems[index].move
        let note = problems[index].note
        let noteArr = note?.componentsSeparatedByString(", ")
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
           // print("noteIndex=\(noteIndex)")

            if piece == "King" {
                color = col == "1" ? .whiteColor() : .blackColor()
                initPos = col == "1" ? 60 : 4
                if color == UIColor.whiteColor(){
                    if noteIndex != 0{
                        noteIndex = 0
                    }
                }
                guard let movesMade = Int(myNoteArr[noteIndex]) else{
                    return
                }
                //let movesMade = Int(n)!
                

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
                guard let pos = Int(onePiece[1]) else{
                    return
                }
                myPiece = Queen(color: color, initPos: board[initPos], currentPos: board[pos])
                
            }else if piece == "K"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 1
                }else{
                    color = UIColor.blackColor()
                    initPos = 57
                }
                guard let pos = Int(onePiece[1]) else{
                    return
                }
                myPiece = Knight(color: color, initPos: board[initPos], currentPos: board[pos])
                
            }else if piece == "B"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 1
                }else{
                    color = UIColor.blackColor()
                    initPos = 57
                }
                guard let pos = Int(onePiece[1]) else{
                    return
                }
                myPiece = Bishop(color: color, initPos: board[initPos], currentPos: board[pos])
                
            }else if piece == "R"{
                if col == "1"{
                    color = UIColor.whiteColor()
                    initPos = 0
                }else{
                    color = UIColor.blackColor()
                    initPos = 56
                }
                //forced unwrapping!!!
                guard let movesMade = Int(myNoteArr[noteIndex]) else{
                    return
                }
                //print("I am rock \(movesMade)")
               // print("and \(noteIndex)")
                noteIndex = noteIndex + 1
                if movesMade == 0 {
                    initPos = board[Int(onePiece[1])!].id
                }
                guard let pos = Int(onePiece[1]) else{
                    return
                }
                myPiece = Rock(color: color, initPos: board[initPos], currentPos: board[pos], movesMade: movesMade)


            }else if piece == "P"{
                if col == "1"{
                    color = UIColor.whiteColor()
                 //   initPos = 0
                }else{
                    color = UIColor.blackColor()
                   // initPos = 56
                }
                guard let pos = Int(onePiece[1]) else{
                    return
                }
                let mp = Pone(color: color, currentPos: board[pos])
                //mp.possibleMoves = mp.detectMoves()
                myPiece = mp
                
            }
           // print("I am adding \(myPiece.name)")
            p.pieces.append(myPiece)
        }
        

        if p.pieces.count - 1 >= 0{
        for index in 0...p.pieces.count - 1{
           // print("I am \(p.pieces[index].name)")
                p.pieces[index].possibleMoves = p.pieces[index].detectMoves()
            }
        }
        
        view2.problem = p
        view2.problems = problems[index]
        view2.probIndex = index
        
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
