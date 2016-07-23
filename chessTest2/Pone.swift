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
    init(color:UIColor, initPos: Cell, currentPos: Cell){
        super.init()
        self.weight = 1
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.pone
        self.board[currentPos.id].taken = self
        print("color: \(color) currentPos.id: \(currentPos.id)")
       // self.movesMade = movesMade
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wpone")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wpone")!
        }else{
            self.img = self.resizeImage(UIImage(named: "bpone")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bpone")!
        }
        //self.possibleMoves = self.detectMoves()
    }
    func detectMoves()->[Move]{
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
        //logic for whites
        if self.color == UIColor.whiteColor(){
            //moves one
            
            if cell.parrent2 != nil && cell.parrent2.taken == nil{
                
                cells.append(cell.parrent2)
                
                //moves 2 cells
                if self.initPos == self.currentPos{
                    if cell.parrent2.parrent2 != nil && cell.parrent2.parrent2.taken == nil{
                        cells.append(cell.parrent2.parrent2)
                    }
                    
                }
            }
            
            //attacking diagonally
            if cell.parrent2 != nil{
                if cell.parrent2.parent1 != nil && cell.parrent2.parent1.taken != nil && cell.parrent2.parent1.taken.color != self.color {
                    print("I am doing it")
                    cells.append(cell.parrent2.parent1)
                }else if cell.parrent2.child1 != nil && cell.parrent2.child1.taken != nil && cell.parrent2.child1.taken.color != self.color {
                    print("I am doing it")
                    cells.append(cell.parrent2.child1)
                }
            }
            
        }else{
            // moves one
            if cell.child2 != nil && cell.child2.taken == nil{
                cells.append(cell.child2)
                
                // moves 2 steps
                if self.initPos == self.currentPos{
                    if cell.child2.child2 != nil && cell.child2.child2.taken == nil{
                        cells.append(cell.child2.child2)
                    }
                    
                }
            }
            // atacking diagonally
            
            if cell.child2 != nil{
                if cell.child2.parent1 != nil && cell.child2.parent1.taken != nil && cell.child2.parent1.taken.color != self.color{
                    print("I am doing it")
                    cells.append(cell.child2.parent1)
                } else if (cell.child2.child1 != nil && cell.child2.child1.taken != nil && cell.child2.child1.taken.color != self.color){
                    print("I am doing it")
                    
                    cells.append(cell.child2.child1)
                }
                
            }
            
            
        }
        
        return cells
    }
    
}