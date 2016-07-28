//
//  Bishop.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/5/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit

class Bishop: Piece{
    var board:[Cell]!
    //var initPict: UIImage!
    init(color:UIColor, initPos: Cell, currentPos: Cell){
        super.init()
        self.weight = 3
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.bishop
        self.board[currentPos.id].taken = self
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "bishop")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bishop")!
        }else{
            self.img = self.resizeImage(UIImage(named: "bbishop")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bbishop")!
        }
        self.possibleMoves = self.detectMoves()
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
    var cells = [Cell]()
    
    func diagon(cell: Cell, iter: Int, caseNum: Int)-> [Cell]{
        if iter == 1{
            cells=[Cell]()
        }
        if caseNum == 1{
            if cell.parent1 != nil{
                if cell.parent1.parrent2 != nil{
                    if cell.parent1.parrent2.taken == nil || cell.parent1.parrent2.taken.color != self.color{
                        cells.append(cell.parent1.parrent2)
                        if self.color == UIColor.whiteColor(){
                            cell.parent1.parrent2.wAttacked = true
                        }else{
                            cell.parent1.parrent2.bAttacked = true
                        }
                        if cell.parent1.parrent2.taken == nil{
                            diagon(cell.parent1.parrent2, iter: 2, caseNum: 1)
                        }else{
                            return cells
                        }
                    }
                }
            }
        }else if caseNum == 2{
            if cell.child1 != nil{
                if cell.child1.parrent2 != nil{
                    if cell.child1.parrent2.taken == nil || cell.child1.parrent2.taken.color != self.color{
                        cells.append(cell.child1.parrent2)
                        //cell.child1.parrent2.isAttacked = true
                        if self.color == UIColor.whiteColor() {
                            cell.child1.parrent2.wAttacked = true
                        }else{
                            cell.child1.parrent2.bAttacked = true
                        }
                        if cell.child1.parrent2.taken == nil{
                            diagon(cell.child1.parrent2, iter: 2, caseNum: 2)
                        }else{
                            return cells
                        }
                    }
                    
                }
            }
        }
        else if caseNum == 3{
            if cell.child1 != nil{
                if cell.child1.child2 != nil{
                    if cell.child1.child2.taken == nil || cell.child1.child2.taken.color != self.color{
                        cells.append(cell.child1.child2)
                        //cell.child1.child2.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.child1.child2.wAttacked = true
                        }else{
                            cell.child1.child2.bAttacked = true
                        }
                        if cell.child1.child2.taken == nil{
                            diagon(cell.child1.child2, iter: 2, caseNum: 3)
                        }else {
                            return cells
                        }
                    }
                    
                }
            }
        }
        else if caseNum == 4{
            if cell.parent1 != nil{
                if cell.parent1.child2 != nil{
                    if cell.parent1.child2.taken == nil || cell.parent1.child2.taken.color != self.color{
                        cells.append(cell.parent1.child2)
                        //cell.parent1.child2.isAttacked = true
                        if self.color == UIColor.whiteColor(){
                            cell.parent1.child2.wAttacked = true
                        }else{
                            cell.parent1.child2.bAttacked = true
                        }
                        if cell.parent1.child2.taken == nil{
                            diagon(cell.parent1.child2, iter: 2, caseNum: 4)
                        }else{
                            return cells
                        }
                    }
                }
            }
        }
        
        return cells
        
    }
    
    
}