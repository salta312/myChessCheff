//
//  Rock.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/6/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit
class Rock: Piece{
    var board:[Cell]!
    var movesMade:Int!
    init(color:UIColor, initPos: Cell, currentPos: Cell){
        super.init()
        self.weight = 5
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.board[currentPos.id].taken = self
        self.name=Pieces.rock
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wrock")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wrock")!
        }else{
            self.img = self.resizeImage(UIImage(named: "brock")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "brock")!
        }
      //  self.possibleMoves = self.detectMoves()
        // board[currentPos]
        
        
    }
    init(color:UIColor, initPos: Cell, currentPos: Cell, movesMade:Int){
        super.init()
        self.weight = 5
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.board[currentPos.id].taken = self
        self.name=Pieces.rock
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wrock")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wrock")!
        }else{
            self.img = self.resizeImage(UIImage(named: "brock")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "brock")!
        }
       // self.possibleMoves = self.detectMoves()
        self.movesMade = movesMade
        // board[currentPos]
        
        
    }
    override func detectMoves()->[Move]{
        var possibleMoves=[Move]()
        for index in 1...4{
            let m=Move()
            m.possibleMoves = diagon(board[currentPos.id], iter: 1, caseNum: index)
            possibleMoves.append(m)
        }
        
        return possibleMoves
        
    }
    /*here is a mistacke we pass new array of cells recursively */
    //i know this is not the best way to solve the problem
    var cells = [Cell]()
    
    func diagon(cell: Cell, iter: Int, caseNum: Int)-> [Cell]{
        if iter == 1{
            cells=[Cell]()
        }
        
        if(caseNum == 1){
            if cell.parent1 != nil{
                print("rock \(cell.parent1.id)")
                if cell.parent1.taken == nil{
                    cells.append(cell.parent1)
                    //cell.parent1.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.parent1.wAttacked = true
                    }else{
                        cell.parent1.bAttacked = true
                    }
                    
                    diagon(cell.parent1, iter: 2, caseNum: 1)
                }else{
                    if cell.parent1.taken.color == self.color{
                        return cells
                    }else{
                        cells.append(cell.parent1)
                        //cell.parent1.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.parent1.wAttacked = true
                        }else{
                            cell.parent1.bAttacked = true
                        }
                        return cells
                    }
                }
            }
        }
            
        else if caseNum == 2{
            if cell.parrent2 != nil{
                print("rock \(cell.parrent2.id)")

                if cell.parrent2.taken == nil {
                    cells.append(cell.parrent2)
                    //cell.parrent2.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.parrent2.wAttacked = true
                    }else{
                        cell.parrent2.bAttacked = true
                    }
                    diagon(cell.parrent2, iter: 2, caseNum: 2)
                }else{
                    if cell.parrent2.taken.color == self.color{
                        return cells
                    }else{
                        cells.append(cell.parrent2)
                        //cell.parrent2.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.parrent2.wAttacked = true
                        }else{
                            cell.parrent2.bAttacked = true
                        }
                        
                    }
                    
                }
            }
        }
            
        else if caseNum == 3{
            
            if cell.child1 != nil{
                print("rock\(cell.child1.id)")

                if cell.child1.taken == nil{
                    cells.append(cell.child1)
                    //cell.child1.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.child1.wAttacked = true
                    }else{
                        cell.child1.bAttacked = true
                    }
                    diagon(cell.child1, iter: 2, caseNum: 3)
                }
                else{
                    if cell.child1.taken.color == self.color{
                        return cells
                    }else{
                        cells.append(cell.child1)
                        //cell.child1.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.child1.wAttacked = true
                        }else{
                            cell.child1.bAttacked = true
                        }
                        return cells
                    }
                    
                }
            }
        }else if caseNum == 4{
            
            if cell.child2 != nil{
                print("rock \(cell.child2.id)")
                if cell.child2.taken == nil{
                    cells.append(cell.child2)
                    //cell.child2.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.child2.wAttacked = true
                    }else{
                        cell.child2.bAttacked = true
                    }
                    diagon(cell.child2, iter: 2, caseNum: 4)
                }
                else{
                    if cell.child2.taken.color == self.color{
                        return cells
                    }else{
                        cells.append(cell.child2)
                        //cell.child2.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.child2.wAttacked = true
                        }else{
                            cell.child2.bAttacked = true
                        }
                        
                        return cells
                    }
                    
                }
            }
        }
        
        
        return cells
        
    }
    
}