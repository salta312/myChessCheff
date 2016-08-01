//
//  Pone.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/11/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit
class Pone: Piece{
    var board:[Cell]!
    var movesMade: Int!
    init(color:UIColor, currentPos:Cell){
        super.init()
        self.weight = 1
        self.board = Board.board
        self.color=color
        //self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.pone
        self.board[currentPos.id].taken = self
        // self.movesMade = movesMade
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wpone")!, targetSize: CGSize(width: CGFloat(currentPos.width), height: CGFloat(currentPos.height)))
            self.initPict = UIImage(named: "wpone")!
            print("currentPos =\(currentPos.id)")
            if currentPos.id != 48 && currentPos.id != 49 && currentPos.id != 50 && currentPos.id != 51 && currentPos.id != 52 && currentPos.id != 53 && currentPos.id != 54 && currentPos.id != 55{
                movesMade = 1
                print("I made one move")

                
            }else{
                movesMade = 0
            }
        }else{
            self.img = self.resizeImage(UIImage(named: "bpone")!, targetSize: CGSize(width: CGFloat(currentPos.width), height: CGFloat(currentPos.height)))
            self.initPict = UIImage(named: "bpone")!
            print("currentPos =\(currentPos.id)")

            if currentPos.id != 8 && currentPos.id != 9 && currentPos.id != 10 && currentPos.id != 11 && currentPos.id != 12 && currentPos.id != 13 && currentPos.id != 14{
                movesMade = 1
                print("I made one move")

            }else{
                movesMade = 0
            }
        }
        self.possibleMoves = self.detectMoves()
    }
    init(color:UIColor, initPos: Cell, currentPos: Cell){
        super.init()
        self.weight = 1
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.pone
        self.board[currentPos.id].taken = self
       // self.movesMade = movesMade
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wpone")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wpone")!
        }else{
            self.img = self.resizeImage(UIImage(named: "bpone")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bpone")!
        }
        self.possibleMoves = self.detectMoves()
    }
    override func detectMoves()->[Move]{
        var possibleMoves=[Move]()
        for _ in 1...1{
            let m=Move()
            m.possibleMoves = diagon(board[currentPos.id])
            possibleMoves.append(m)
        }
        
        return possibleMoves
        
    }
    var cells = [Cell]()
    
    //write a code to turn into something else
    
    
    func diagon(cell: Cell)-> [Cell]{
        var cells = [Cell]()
        //add atacking
        //increase amount of moves made
        //logic for whites
        //print(self.color)
        if self.color == UIColor.whiteColor(){
           // print("I am white")
            //moves one
            
            if cell.parrent2 != nil && cell.parrent2.taken == nil{
                
                cells.append(cell.parrent2)
                
                //moves 2 cells
                if (self.initPos != nil && self.initPos == self.currentPos) || (movesMade != nil && movesMade == 0){
                    if cell.parrent2.parrent2 != nil && cell.parrent2.parrent2.taken == nil{
                        cells.append(cell.parrent2.parrent2)
                    }
                    
                }
                
                
                //self.movesMade++
            }
            
            //attacking diagonally
            if cell.parrent2 != nil{
                if cell.parrent2.parent1 != nil{
                    cell.parrent2.parent1.wAttacked = true
                if cell.parrent2.parent1.taken != nil && cell.parrent2.parent1.taken.color != self.color {
                    cells.append(cell.parrent2.parent1)
                    }
                }
                if cell.parrent2.child1 != nil {
                    cell.parrent2.child1.wAttacked = true
                    if cell.parrent2.child1.taken != nil && cell.parrent2.child1.taken.color != self.color {
                    cells.append(cell.parrent2.child1)
                }
                }
                
            }
            
        }else{
            // moves one
           // print("I am black")
            if cell.child2 != nil && cell.child2.taken == nil{
                cells.append(cell.child2)
                
                // moves 2 steps
                if (self.initPos != nil && self.initPos == self.currentPos) || (movesMade != nil && movesMade == 0){
                    if cell.child2.child2 != nil && cell.child2.child2.taken == nil{
                        cells.append(cell.child2.child2)
                    }
                    
                }
            }
            // atacking diagonally
            
            if cell.child2 != nil{
                if cell.child2.parent1 != nil {
                    cell.child2.parent1.bAttacked = true
                    if cell.child2.parent1.taken != nil && cell.child2.parent1.taken.color != self.color{
                        cells.append(cell.child2.parent1)
                    }
                }
                if cell.child2.child1 != nil{
                    cell.child2.child1.bAttacked = true
                    if cell.child2.child1.taken != nil && cell.child2.child1.taken.color != self.color{
                    
                        cells.append(cell.child2.child1)
                    }
                }
                
            }
            
        }
        
        return cells
    }
    
}