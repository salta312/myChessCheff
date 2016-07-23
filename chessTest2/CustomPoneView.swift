//
//  CustomPoneView.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class CustomPoneView: UIView {
    var color: UIColor!
    var piece: Piece!
    override func drawRect(rect: CGRect) {
        let width = self.frame.size.width
        let height = self.frame.size.height
        let widthForOnePiece = Float(width/CGFloat(piece.weight)) - 50
       // var heightForOnePiece = CGFloat(height/CGFloat(piece.weight)) - 50
        for index in 0...piece.weight{
            let temp = Float(index) + Float(widthForOnePiece)
            _ = CGPoint(x:CGFloat(temp), y: CGFloat(height))
           // UIImage(named: ")
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
