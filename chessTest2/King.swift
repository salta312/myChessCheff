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
 //   var board:[Cell]!
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
        //self.possibleMoves = self.detectMoves()
    }
    override func movesMade(finalPos: Cell){
        var br = false
        var cells: [Cell]!
        guard let possibleM = possibleMoves else{
            return
        }
        if (self.color == UIColor.whiteColor() && (finalPos.id == 62 || finalPos == 58) || self.color == UIColor.blackColor() && (finalPos.id == 62 || finalPos == 58)) && movesMade == 0{
        if self.color == UIColor.whiteColor() && movesMade == 0{
            if board[63].taken != nil && board[63].taken.name == Pieces.rock  && finalPos.id == 62{
                let rock = board[63].taken as! Rock
                if rock.movesMade == 0 && (board[62].taken == nil || board[62].taken == false)  && (board[61].taken == nil || board[61].taken == false){
                    //cellArray.append(board[62])
                    self.currentPos = board[62]
                    board[62].taken = self
                    board[60].taken = nil
                    rock.currentPos = board[61]
                    board[61].taken = self
                    board[63].taken = nil
                    
                }
            }
            if board[56].taken != nil && board[56].taken.name == Pieces.rock && finalPos == 58{
                let rock = board[56].taken as! Rock
                if rock.movesMade == 0 && (board[57].taken == nil || board[57].taken == false) && (board[58].taken == nil || board[58].taken == false) && (board[59].taken == nil || board[59].taken == false){
                    self.currentPos = board[58]
                    board[58].taken = self
                    board[60].taken = nil
                    rock.currentPos = board[59]
                    board[59].taken = self
                    board[56].taken = nil
                    
                }
            }
            
        }else if self.color == UIColor.blackColor() && movesMade == 0{
            if board[7].taken != nil && board[7].taken.name == Pieces.rock && finalPos == 6{
                let rock = board[7].taken as! Rock
                if rock.movesMade == 0 && (board[6].taken == nil || board[6].taken == false)  && (board[5].taken == nil || board[5].taken == false){
                    self.currentPos = board[6]
                    board[6].taken = self
                    board[4].taken = nil
                    rock.currentPos = board[7]
                    board[5].taken = self
                    board[7].taken = nil
                }
            }
            if board[0].taken != nil && board[0].taken.name == Pieces.rock{
                let rock = board[0].taken as! Rock
                if rock.movesMade == 0 && (board[1].taken == nil || board[1].taken == false) && (board[2].taken == nil || board[2].taken == false) && (board[3].taken == nil || board[3].taken == false){
                    board[2].taken = self
                    board[4].taken = nil
                    rock.currentPos = board[0]
                    board[3].taken = self
                    board[0].taken = nil
                }
            }
            
        }
        }else{
        if possibleM.count - 1 >= 0{
            for index in 0...possibleM.count-1{
                cells = possibleM[index].possibleMoves
                if cells.count - 1 >= 0{
                    for index1 in 0...cells.count-1{
                        if cells[index1].id == finalPos.id{
                            self.currentPos = finalPos
                            board[currentPos.id].taken = nil
                            board[finalPos.id].taken = self
                            self.movesMade = self.movesMade + 1
                            br = true
                            break
                            
                        }
                    }
                }
                if br{
                    break
                }
            }
        }
        }
        
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
    func castleQueenSide()->[Cell]{
        var cellArray = [Cell]()
        if self.color == UIColor.whiteColor() && movesMade == 0{
            if board[63].taken != nil && board[63].taken.name == Pieces.rock{
                let rock = board[63].taken as! Rock
                if rock.movesMade == 0 && (board[62].taken == nil || board[62].taken == false)  && (board[61].taken == nil || board[61].taken == false){
                    cellArray.append(board[62])
                }
            }
            if board[56].taken != nil && board[56].taken.name == Pieces.rock{
                let rock = board[56].taken as! Rock
                if rock.movesMade == 0 && (board[57].taken == nil || board[57].taken == false) && (board[58].taken == nil || board[58].taken == false) && (board[59].taken == nil || board[59].taken == false){
                    cellArray.append(board[58])
                }
            }
            
        }else if self.color == UIColor.blackColor() && movesMade == 0{
            if board[7].taken != nil && board[7].taken.name == Pieces.rock{
                let rock = board[7].taken as! Rock
                if rock.movesMade == 0 && (board[6].taken == nil || board[6].taken == false)  && (board[5].taken == nil || board[5].taken == false){
                    cellArray.append(board[6])
                }
            }
            if board[0].taken != nil && board[0].taken.name == Pieces.rock{
                let rock = board[0].taken as! Rock
                if rock.movesMade == 0 && (board[1].taken == nil || board[1].taken == false) && (board[2].taken == nil || board[2].taken == false) && (board[3].taken == nil || board[3].taken == false){
                    cellArray.append(board[2])
                }
            }

        }
        return cellArray
    }
    
    func diagon(cell: Cell, iter: Int, caseNum: Int)-> [Cell]{
        if iter == 1{
            cells=[Cell]()
            cells = self.castleQueenSide()
        }
        if(caseNum == 1){
            if( cell.parent1 != nil) {
                if self.color == UIColor.whiteColor(){
                    cell.parent1.wKingMove = true
                }else{
                    cell.parent1.bKingMove = true
                }
                if (self.color == UIColor.whiteColor() && cell.parent1.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.wAttacked != true) && (cell.parent1.taken == nil || cell.parent1.taken.color != self.color){

                    
                    cells.append(cell.parent1)
                }
            }
        }else if caseNum == 2{
            if cell.parent1 != nil {
                if cell.parent1.parrent2 != nil {
                    if self.color == UIColor.whiteColor(){
                        cell.parent1.parrent2.wKingMove = true
                    }else{
                        cell.parent1.parrent2.bKingMove = true
                    }
                    if (self.color == UIColor.whiteColor() && cell.parent1.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.parrent2.wAttacked != true) && (cell.parent1.parrent2.taken == nil || cell.parent1.parrent2.taken.color != self.color){

                        cells.append(cell.parent1.parrent2)
                    }
                }
            }
        }else if caseNum == 3{
            if cell.parrent2 != nil{
                if self.color == UIColor.whiteColor(){
                    cell.parrent2.wKingMove = true
                }else{
                    cell.parrent2.bKingMove = true
                }
                if (self.color == UIColor.whiteColor() && cell.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parrent2.wAttacked != true) && (cell.parrent2.taken == nil || cell.parrent2.taken.color != self.color) {

                    cells.append(cell.parrent2)
                }
                
            }
            
        }else if caseNum == 4{
            if cell.child1 != nil{
                if cell.child1.parrent2 != nil{
                    if self.color == UIColor.whiteColor(){
                        cell.child1.parrent2.wKingMove = true
                    }else{
                        cell.child1.parrent2.bKingMove = true
                    }
                    if ((self.color == UIColor.whiteColor() && cell.child1.parrent2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child1.parrent2.wAttacked != true)) && (cell.child1.parrent2.taken == nil || cell.child1.parrent2.taken.color != self.color){

                        cells.append(cell.child1.parrent2)
                    }
                    
                }
            }
        }
        else if caseNum == 5{
            if cell.child1 != nil{
                if self.color == UIColor.whiteColor(){
                    cell.child1.wKingMove = true
                }else{
                    cell.child1.bKingMove = true
                }
                if (self.color == UIColor.whiteColor() && cell.child1.bAttacked != true) || (self.color == UIColor.blackColor() && (cell.child1.wAttacked != true)) && (cell.child1.taken == nil || cell.child1.taken.color != self.color){

                    cells.append(cell.child1)
                }
            }
        }else if caseNum == 6{
            if cell.child1 != nil{
                if cell.child1.child2 != nil{
                    if self.color == UIColor.whiteColor(){
                        cell.child1.child2.wKingMove = true
                    }else{
                        cell.child1.child2.bKingMove = true
                    }
                    if (self.color == UIColor.whiteColor() && cell.child1.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child1.child2.wAttacked != true) && (cell.child1.child2.taken == nil || cell.child1.child2.taken.color != self.color){

                        cells.append(cell.child1.child2)
                    }
                    
                }
            }
        }
        else if caseNum == 7{
            if cell.child2 != nil{
                if self.color == UIColor.whiteColor(){
                    cell.child2.wKingMove = true
                }else{
                    cell.child2.bKingMove = true
                }
                if (self.color == UIColor.whiteColor() && cell.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.child2.wAttacked != true) && (cell.child2.taken == nil || cell.child2.taken.color != self.color){

                    cells.append(cell.child2)
                }
            }
        }else if caseNum == 8{
            if cell.parent1 != nil{
                if cell.parent1.child2 != nil{
                    if self.color == UIColor.whiteColor(){
                        cell.parent1.child2.wKingMove = true
                    }else{
                        cell.parent1.child2.bKingMove = true
                    }
                    if (self.color == UIColor.whiteColor() && cell.parent1.child2.bAttacked != true) || (self.color == UIColor.blackColor() && cell.parent1.child2.wAttacked != true) && (cell.parent1.child2.taken == nil || cell.parent1.child2.taken.color != self.color){

                        cells.append(cell.parent1.child2)
                    }
                }
            }
        }
        return cells
    }
    func isCheck() -> Bool{
        if (self.color == UIColor.whiteColor() && self.currentPos.bAttacked == true) || (self.color == UIColor.blackColor() && self.currentPos.wAttacked == true){
            return true
        }
        return false
    }
    
}