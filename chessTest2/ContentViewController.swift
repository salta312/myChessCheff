//
//  ContentViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/13/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class ContentViewController: UIViewController {
   // var views = [UIView]()
    var lesson:Lesson!
    var currentNum: Int!
    var total:Int!
    var prot: NextPreviousProtcol!
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.fontWithSize(10)
        //label.backgroundColor = UIColor.blackColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "\(self.currentNum  + 1) из \(self.total)"
        label.font = label.font.fontWithSize(20)
        label.textColor = UIColor.whiteColor()
       // label.text = "Test"
        return label
    }()
    lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button.setImage(UIImage(named:"books"), forState: .Normal)
        button.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
        return button
        
    }()
    func goBack(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.draw()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button2.layer.cornerRadius = button2.bounds.size.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(){
        let v = MyView1()
        _ = view.frame.size.width
        v.lesson = self.lesson
        view.backgroundColor = UIColor(red: 249/255, green: 97/255, blue: 91/255, alpha: 1)
        print(self.view.frame.size.height)
        if self.view.frame.size.height > 500{
            print("I am here")
            label.font = label.font.fontWithSize(CGFloat(15))
        }
        [button2, label, label1].forEach { self.view.addSubview($0) }
        self.view.addSubview(v)
        label.text = lesson.text
        _ = Cell.Sheight*8+50
        constrain(view, v, label, label1, button2){
            view, v, label, label1, button2 in
            label1.top == view.top + 64
            label1.centerX == view.centerX
            v.top == label1.bottom
            v.centerX == view.centerX
            v.height == CGFloat(Cell.Sheight*8)
            v.width == CGFloat(Cell.SWidth*8)
            label.top == v.bottom + 27
            label.centerX == v.centerX
            label.right == v.right - 38
            label.left == v.left + 38
            button2.bottom == view.bottom
            button2.centerX == view.centerX
            button2.height == CGFloat(50)
            button2.width == CGFloat(50)
            

        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.stringForKey("screenWidth") != nil{
        }else{
         defaults.setFloat(Float(v.frame.size.height), forKey: "screenHeight")
         defaults.setFloat(Float(v.frame.size.width), forKey: "screenWidth")
        }


        

    }
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
    func next(){
        prot.next(currentNum)
    }
    func previous(sender: UIButton){
        prot.previous(currentNum)
    }


}
