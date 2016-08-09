//
//  Piece.swift
//  chessTest1
//
//  Created by Saltanat Aimakhanova on 7/5/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit

class Piece:NSObject{
    
    var initPict = UIImage(named: "bishop")!
    var color:UIColor!
    var initPos:Cell!
    var currentPos:Cell!
    var name:Pieces!
    var possibleMoves: [Move]?
    var img:UIImage!
    var weight:Int!
    var board = Board.produceABoard()
    func resizeImage(image:UIImage, targetSize: CGSize) -> UIImage{
        let size=image.size
        let widthRatio=targetSize.width / image.size.width
        let heightRatio=targetSize.height/image.size.height
        var newSize: CGSize
        if widthRatio > heightRatio{
            newSize=CGSizeMake(size.width*heightRatio, size.height*heightRatio)
        }else{
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        let rect=CGRectMake(0, 0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func detectMoves()->[Move]{
        let possibleMoves=[Move]()
        return possibleMoves
        
    }
    func movesMade(finalPos: Cell){
        var br = false
        var cells: [Cell]!
        guard let possibleM = possibleMoves else{
            return
        }
        if possibleM.count - 1 >= 0{
            for index in 0...possibleM.count-1{
                 cells = possibleM[index].possibleMoves
                if cells.count - 1 >= 0{
                    for index1 in 0...cells.count-1{
                        if cells[index1].id == finalPos.id{
                            self.currentPos = finalPos
                            board[currentPos.id].taken = nil
                            board[finalPos.id].taken = self
                            br = true
                            break
                            //Board.cleanABoard()
                            
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