//
//  Cell.swift
//  chessTest
//
//  Created by Saltanat Aimakhanova on 7/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import Foundation
import UIKit

class Cell: NSObject{
    static var Sheight: Float!
    static var SWidth: Float!
    var taken: Piece!
    var x: Float!
    var y: Float!
    var id: Int!
    //var isAttacked:Bool!
    var wAttacked: Bool!
    var bAttacked: Bool!
    var wKingMove: Bool!
    var bKingMove: Bool!
    var height = Sheight
    var width = SWidth
//    var width = Float(250/8)
//    var height = Float(250/8)
    
//    var width: Float{
//        get{
//            let defaults = NSUserDefaults.standardUserDefaults()
//            let w=(defaults.floatForKey("screenWidth"))/8
//            return w
//        }
//    }
//    var height: Float{
//        get{
//            let defaults = NSUserDefaults.standardUserDefaults()
//            let w=(defaults.floatForKey("screenHeight"))/8
//            return w
//        }
//    }
    var color: UIColor!
    var parent1:Cell!
    var parrent2:Cell!
    var child1:Cell!
    var child2:Cell!
    func setBoardWidth(){
        
    }
    
}