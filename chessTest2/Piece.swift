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
    func resizeImage(image:UIImage, targetSize: CGSize) -> UIImage{
        print( self.name)
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
}