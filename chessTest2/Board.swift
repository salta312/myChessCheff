//
//  Board.swift
//  chessTest
//
//  Created by Saltanat Aimakhanova on 7/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit
class Board: NSObject{
    
    static var board = Board.produceABoard()
    
    static func produceABoard()-> [Cell]{
        var board = [Cell]()
        for index in 0...63{
           // print(index)
            let cell=Cell()
            cell.id=index
            if (index == 0){
                cell.color = UIColor.yellowColor()
                cell.x=0
                cell.y=0
                board.append(cell)
                continue
            } else if (index%8 == 0){
                let cell1=board[index-8]
                cell.parrent2=cell1
                cell1.child2=cell
                cell.x=cell1.x
                cell.y=cell1.y + cell1.height
                if cell1.color == UIColor.brownColor(){
                    cell.color=UIColor.yellowColor()
                }else{
                    cell.color=UIColor.brownColor()
                }
                board.append(cell)

                continue
                
            }else if (index - 1 >= 0){
                let cell1=board[index - 1]
                cell.parent1=cell1
                cell1.child1=cell
                //print("\(cell1.height) \(cell1.width)")
                cell.x = cell1.x + cell1.width
                if cell.parent1.color == UIColor.brownColor(){
                    cell.color=UIColor.yellowColor()
                }else{
                    cell.color=UIColor.brownColor()
                }
                cell.y = cell1.y
                if(index - 8 >= 0){
                    let cell2=board[index - 8]
                    cell2.child2=cell
                    cell.parrent2=cell2
                    if cell2.color != cell1.color{
                        print("error")
                    }
                }
                board.append(cell)
            }            
        }
        return board
    }
   static func cleanABoard(){
        //let b = Board.board
        for index in 0...Board.board.count - 1{
            Board.board[index].bAttacked = false
            Board.board[index].wAttacked = false
            Board.board[index].taken = nil
        }
        
    }
    static func findKings()->[King]{
        var kings = [King]()
        for index in 0...board.count-1{
            if board[index].taken != nil && board[index].taken.name == Pieces.king{
                kings.append(board[index].taken as! King)
            }
            
        }
        return kings
    }
}
