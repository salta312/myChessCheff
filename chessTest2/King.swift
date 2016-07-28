//
//  King.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/7/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit
class King: Piece{
    var board:[Cell]!
    var movesMade: Int!
    init(color:UIColor, initPos: Cell, currentPos: Cell, movesMade: Int){
        super.init()
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.king
        self.movesMade = movesMade
        self.board[currentPos.id].taken = self
        
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wking")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wking")!
        }else{
            self.img = self.resizeImage(UIImage(named: "bking")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bking")!
        }
        self.possibleMoves = self.detectMoves()
    }
    override func detectMoves()->[Move]{
        var possibleMoves=[Move]()
        for index in 1...8{
            let m=Move()
            m.possibleMoves = diagon(board[currentPos.id], iter: 1, caseNum: index)
            possibleMoves.append(m)
        }
        
        return possibleMoves
        
    }
    var cells = [Cell]()
    
    func diagon(cell: Cell, iter: Int, caseNum: Int)-> [Cell]{
        if iter == 1{
            cells=[Cell]()
        }
        if(caseNum == 1){
            if( cell.parent1 != nil) {
                if (self.color == UIColor.whiteColor() && cell.parent1.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.wAttacked != true) && (cell.parent1.taken == nil || cell.parent1.taken.color != self.color){
                    cells.append(cell.parent1)
                }
            }
        }else if caseNum == 2{
            if cell.parent1 != nil {
                if cell.parent1.parrent2 != nil {
                    if (self.color == UIColor.whiteColor() && cell.parent1.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.parrent2.wAttacked != true) && (cell.parent1.parrent2.taken == nil || cell.parent1.parrent2.taken.color != self.color){
                        cells.append(cell.parent1.parrent2)
                    }
                }
            }
        }else if caseNum == 3{
            if cell.parrent2 != nil{
                if (self.color == UIColor.whiteColor() && cell.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parrent2.wAttacked != true) && (cell.parrent2.taken == nil || cell.parrent2.taken.color != self.color) {
                    cells.append(cell.parrent2)
                }
                
            }
            
        }else if caseNum == 4{
            if cell.child1 != nil{
                if cell.child1.parrent2 != nil{
                    if ((self.color == UIColor.whiteColor() && cell.child1.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child1.parrent2.wAttacked != true)) && (cell.child1.parrent2.taken == nil || cell.child1.parrent2.taken.color != self.color){
                        cells.append(cell.child1.parrent2)
                    }
                    
                }
            }
        }
        else if caseNum == 5{
            if cell.child1 != nil{
                if (self.color == UIColor.whiteColor() && cell.child1.bAttacked != true) || (self.color == UIColor.blackColor() && (cell.child1.wAttacked != true)) && (cell.child1.taken == nil || cell.child1.taken.color != self.color){
                    cells.append(cell.child1)
                }
            }
        }else if caseNum == 6{
            if cell.child1 != nil{
                if cell.child1.child2 != nil{
                    if (self.color == UIColor.whiteColor() && cell.child1.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child1.child2.wAttacked != true) && (cell.child1.child2.taken == nil || cell.child1.child2.taken.color != self.color){
                        cells.append(cell.child1.child2)
                    }
                    
                }
            }
        }
        else if caseNum == 7{
            if cell.child2 != nil{
                if (self.color == UIColor.whiteColor() && cell.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child2.wAttacked != true) && (cell.child2.taken == nil || cell.child2.taken.color != self.color){
                    cells.append(cell.child2)
                }
            }
        }else if caseNum == 8{
            if cell.parent1 != nil{
                if cell.parent1.child2 != nil{
                    if (self.color == UIColor.whiteColor() && cell.parent1.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.child2.wAttacked != true) && (cell.parent1.child2.taken == nil || cell.parent1.child2.taken.color != self.color){
                        cells.append(cell.parent1.child2)
                    }
                }
            }
        }
        return cells
    }
    
}