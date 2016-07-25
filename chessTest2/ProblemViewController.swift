//
//  ProblemViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class ProblemViewController: UIViewController {
    var board = Board.board
    var problems: [Problems]!
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.redColor()
        Board.cleanABoard()
        //add shuffle
        setAPosition()
        
        

        // Do any additional setup after loading the view.
    }
    func setAPosition(){
        Board.cleanABoard()
        if index >= problems.count {
            return
        }
        let tempString = problems[index].composition
       // let piecesArr = split(tempString){$0 == ", "}
        let piecesArr = tempString?.componentsSeparatedByString(", ")
        guard let piecesArr1 = piecesArr else{
            return
        }
        for index in 0...piecesArr1.count-1{
            //print(piecesArr1[index])
            let onePiece = piecesArr1[index].componentsSeparatedByString(" ")
            print(onePiece[0].endIndex)
            
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
