//
//  PiecesWeightViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
protocol NextPreviousProtcol1{
    func next(currentPage: Int!)
    func previous(currentPage: Int!)
}

class PiecesWeightViewController: UIPageViewController, NextPreviousProtcol1 {
    var lessons: [Lesson]!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.dataSource = self
        self.delegate = self
        
        setViewControllers([newContentViewController(0)] , direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func newContentViewController(index: Int)-> WeightViewController{
        let vc = WeightViewController()
        vc.lesson = lessons[index]
        vc.currentNum = index
        vc.total = lessons.count
        vc.prot = self
        return vc
    }
    func next(currentPage: Int!){
        
        if currentPage + 1 >= lessons.count{
            return
        }
        //let contentVC = newContentViewController(currentPage + 1)
        setViewControllers([newContentViewController(currentPage + 1)] , direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        //return contentVC
        
    }
    func previous(currentPage: Int!) {
        if currentPage - 1 < 0{
            return
        }
        // let contentVC = newContentViewController(currentPage - 1)
        setViewControllers([newContentViewController(currentPage - 1)] , direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        //return contentVC
    }
    
}
extension PiecesWeightViewController: UIPageViewControllerDelegate{
}

extension PiecesWeightViewController: UIPageViewControllerDataSource{
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //print("I call you too")
        
        let contentVC = viewController as! WeightViewController
        let l = contentVC.lesson
        guard let lessonNum = lessons.indexOf(l) else{
            return nil
        }
        let nextIndex = lessonNum + 1
        if nextIndex >= lessons.count{
            return nil
        }
        contentVC.currentNum = nextIndex
        contentVC.total = self.lessons.count
        
        return newContentViewController(nextIndex)
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        // print("I call you")
        
        let contentVC = viewController as! WeightViewController
        let l = contentVC.lesson
        guard let lessonNum = lessons.indexOf(l) else{
            return nil
        }
        let previousIndex = lessonNum - 1
        guard previousIndex>=0 else{
            return nil
        }
        contentVC.currentNum = previousIndex
        contentVC.total = self.lessons.count
        
        return newContentViewController(previousIndex)
    }
}
