//
//  AdditionalLessonsViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/9/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class AdditionalLessonsViewController: UIViewController {
    var lessons = [Lesson]()
    var board = Board.board
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newcolor = UIColor(red: 236/255, green: 224/255, blue: 213/255, alpha: 1)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1/255, green: 152/255, blue: 215/255, alpha: 1)
        navigationItem.title = "Урок 3 - Дополнительный материал"
        view.backgroundColor = UIColor.whiteColor()
        Board.cleanABoard()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 249/255, green: 97/255, blue: 91/255, alpha: 1)
        let less1 = Lesson()
        let pieces1 = [King(color: UIColor.blackColor(), initPos: board[3], currentPos: board[28], movesMade: 1), King(color: UIColor.whiteColor(), initPos: board[60], currentPos: board[34], movesMade: 1) ]
        less1.pieces = pieces1
        less1.col = [UIColor.blackColor(), newcolor]
        less1.text = "Ферзь ходит по вертикалям, горизонталям и диагоналям"
        let less2 = Lesson()
        let pieces2 = [Rock(color: UIColor.whiteColor(), initPos: board[63], currentPos: board[28])]
        
        less2.pieces = pieces2
        less2.col = [newcolor]
        less2.text = "Ладья ходит только по вертикалям и горизонталям"
        lessons.append(less1)
        lessons.append(less2)
        let less3 = Lesson()
        let pices3 = [Bishop(color:UIColor.whiteColor(), initPos: board[58], currentPos: board[28])]
        less3.pieces = pices3
        less3.col = [newcolor]
        less3.text = "Слон ходит по диагонали"
        lessons.append(less3)
        let less4 = Lesson()
        let pieces4 = [Knight(color: UIColor.blackColor(), initPos: board[1], currentPos: board[28])]
        less4.pieces = pieces4
        less4.col = [UIColor.blackColor()]
        less4.text = "Конь ходит буквой Г: 2 клетки по прямой (вертикали или горизонтали) и 1 клетка сворачивает"
        lessons.append(less4)
        
        let less5 = Lesson()
        let pone1 = Pone(color: UIColor.blackColor(), initPos: board[9], currentPos: board[41])
        let pone2 = Pone(color: UIColor.whiteColor(), initPos:board[48], currentPos: board[48])
        pone1.possibleMoves = pone1.detectMoves()
        pone2.possibleMoves = pone2.detectMoves()
        let pieces5 = [pone1, pone2]
        less5.pieces = pieces5
        less5.col = [UIColor.blackColor(), newcolor]
        less5.text = "Пешка ходит по прямой на 1 (всегда) или на 2 клетки (если пешка не сделала еще хода), а бьет по диагонали"
        lessons.append(less5)
        let less6 = Lesson()
        let king = King(color: UIColor.whiteColor(), initPos: board[60], currentPos: board[8], movesMade: 1)
        let queen = Queen(color: UIColor.blackColor(), initPos: board[3], currentPos: board[28])
        let pieces6 = [king, queen]
        less6.pieces = pieces6
        less6.text =  "Король может ходить по всем направлениям на 1 клетку (по горизонтали, вертикали и диагонали), кроме клеток атакованных другими фигурами"
        less6.col = [newcolor, UIColor.blackColor()]
        lessons.append(less6)
        
        self.draw()
        
    }
    
    func draw(){
        view.backgroundColor = UIColor.blackColor()
        
        let lesson = LessonViewController()
        addChildViewController(lesson)
        lesson.didMoveToParentViewController(self)
        
        lesson.lessons = self.lessons
        let v = lesson.view
        view.addSubview(v)
        
        constrain(view, v){
            view, v in
            v.centerX == view.centerX
            v.top == view.top
            v.width == view.width
            v.height == view.height
            
            
        }
        
        
    }
    
    
    
    
    
}