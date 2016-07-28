//
//  Queen.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/7/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit
class Queen: Piece{
    var board:[Cell]!
    init(color:UIColor, initPos: Cell, currentPos: Cell){
        super.init()
        self.weight = 9
        self.board = Board.board
        self.color=color
        self.initPos=initPos
        self.currentPos=currentPos
        self.name=Pieces.queen
        self.board[currentPos.id].taken = self
        if color == UIColor.whiteColor(){
            self.img = self.resizeImage(UIImage(named: "wqueen")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "wqueen")!
        }else{
            self.img = self.resizeImage(UIImage(named: "bqueen")!, targetSize: CGSize(width: CGFloat(initPos.width), height: CGFloat(initPos.height)))
            self.initPict = UIImage(named: "bqueen")!
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
            if cell.parent1 != nil{
                if cell.parent1.taken == nil || cell.parent1.taken.color != self.color{
                    cells.append(cell.parent1)
                    if self.color == UIColor.whiteColor() {
                        cell.parent1.wAttacked = true
                    }else{
                        cell.parent1.bAttacked = true
                        
                    }
                    if cell.parent1.taken == nil{
                        diagon(cell.parent1, iter: 2, caseNum: 1)
                    }else{
                        return cells
                    }
                }
            }
        }else if caseNum == 2{
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
                            diagon(cell.parent1.parrent2, iter: 2, caseNum: 2)
                        }else{
                            return cells
                        }
                    }
                }
            }
        }else if caseNum == 3{
            if cell.parrent2 != nil{
                if cell.parrent2.taken == nil || cell.parrent2.taken.color != self.color{
                    cells.append(cell.parrent2)
                    //cell.parrent2.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.parrent2.wAttacked = true
                    }else{
                        cell.parrent2.bAttacked = true
                    }
                    if cell.parrent2.taken == nil{
                        diagon(cell.parrent2, iter: 2, caseNum: 3)
                    }else{
                        return cells
                    }
                }
                
            }
            
        }else if caseNum == 4{
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
                            diagon(cell.child1.parrent2, iter: 2, caseNum: 4)
                        }else{
                            return cells
                        }
                    }
                    
                }
            }
        }
        else if caseNum == 5{
            if cell.child1 != nil{
                if cell.child1.taken == nil || cell.child1.taken.color != self.color{
                    cells.append(cell.child1)
                    //cell.child1.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.child1.wAttacked = true
                    }else{
                        cell.child1.bAttacked = true
                    }
                    if cell.child1.taken == nil{
                        diagon(cell.child1, iter: 2, caseNum: 5)
                    }else{
                        return cells
                    }}
            }
        }else if caseNum == 6{
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
                            diagon(cell.child1.child2, iter: 2, caseNum: 6)
                        }else {
                            return cells
                        }
                    }
                    
                }
            }
        }
        else if caseNum == 7{
            if cell.child2 != nil{
                if cell.child2.taken == nil || cell.child2.taken.color != self.color{
                    cells.append(cell.child2)
                    //cell.child2.isAttacked = true
                    if self.color == UIColor.whiteColor(){
                        cell.child2.wAttacked = true
                    }else{
                        cell.child2.bAttacked = true
                    }
                    if cell.child2.taken == nil{
                        diagon(cell.child2, iter: 2, caseNum: 7)
                    }else{
                        return cells
                    }
                }
            }
        }else if caseNum == 8{
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
                            diagon(cell.parent1.child2, iter: 2, caseNum: 8)
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