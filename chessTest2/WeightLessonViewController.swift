//
//  WeightLessonViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class WeightLessonViewController: UIViewController {
    var lessons = [Lesson]()
    var board = Board.board

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .blueColor()
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.title = "Menu"
        leftBarButtonItem.target = self
        leftBarButtonItem.action = #selector(barButtonItemClicked(_:))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        // Do any additional setup after loading the view.
        let less1 = Lesson()
        let pieces1 = [Queen(color: UIColor.blackColor(), initPos: board[3], currentPos: board[28])]
        less1.pieces = pieces1
        less1.col = [UIColor.redColor()]
        less1.text = "Ферзь ходит по вертикалям, горизонталям и диагоналям"
        let less2 = Lesson()
        let pieces2 = [Rock(color: UIColor.whiteColor(), initPos: board[63], currentPos: board[28])]
        
        less2.pieces = pieces2
        less2.col = [UIColor.redColor()]
        less2.text = "Ладья ходит только по вертикалям и горизонталям"
        lessons.append(less1)
        lessons.append(less2)
        let less3 = Lesson()
        let pices3 = [Bishop(color:UIColor.whiteColor(), initPos: board[58], currentPos: board[28])]
        less3.pieces = pices3
        less3.col = [UIColor.redColor()]
        less3.text = "Слон ходит по диагонали"
        lessons.append(less3)
        let less4 = Lesson()
        let pieces4 = [Knight(color: UIColor.blackColor(), initPos: board[1], currentPos: board[28])]
        less4.pieces = pieces4
        less4.col = [UIColor.redColor()]
        less4.text = "Конь ходит буквой Г: 2 клетки по прямой (вертикали или горизонтали) и 1 клетка сворачивает"
        lessons.append(less4)
        
        let less5 = Lesson()
        let pone1 = Pone(color: UIColor.blackColor(), initPos: board[9], currentPos: board[41])
        let pone2 = Pone(color: UIColor.whiteColor(), initPos:board[48], currentPos: board[48])
        pone1.possibleMoves = pone1.detectMoves()
        pone2.possibleMoves = pone2.detectMoves()
        let pieces5 = [pone1, pone2]
        less5.pieces = pieces5
        less5.col = [UIColor.redColor(), UIColor.cyanColor()]
        less5.text = "Пешка ходит по прямой на 1 (всегда) или на 2 клетки (если пешка не сделала еще хода), а бьет по диагонали"
        lessons.append(less5)
        let less6 = Lesson()
        let king = King(color: UIColor.whiteColor(), initPos: board[60], currentPos: board[8], movesMade: 1)
        let queen = Queen(color: UIColor.blackColor(), initPos: board[3], currentPos: board[28])
        let pieces6 = [king, queen]
        less6.pieces = pieces6
        less6.text =  "Король может ходить по всем направлениям на 1 клетку (по горизонтали, вертикали и диагонали), кроме клеток атакованных другими фигурами"
        less6.col = [UIColor.whiteColor(), UIColor.blackColor()]
        lessons.append(less6)
        self.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barButtonItemClicked(button: UIBarButtonItem){
        //print("I work")
        toggleSideMenuView()
    }
    func draw(){
        let lesson = PiecesWeightViewController()
        addChildViewController(lesson)
        lesson.didMoveToParentViewController(self)
        
        lesson.lessons = self.lessons
        let v = lesson.view
        //v.layer.borderWidth = 1
        view.addSubview(v)
        // view.addSubview(label)
        //view.addSubview(lessonContainer)
        // var distance = UIApplication.sharedApplication().statusBarFrame.size.height + 5
        constrain(view, v){
            view, v in
            v.centerX == view.centerX
            v.top == view.top
            v.width == view.width
            v.height == view.height
            // label.top == v.bottom + 50
            // label.width == v.width
            //label.centerX == v.centerX
            
        }
        print(view.frame.size.height)
        print(view.frame.size.width)
        

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
