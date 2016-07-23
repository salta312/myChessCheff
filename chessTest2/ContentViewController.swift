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
    var lesson:Lesson!
    var currentNum: Int!
    var total:Int!
    var prot: NextPreviousProtcol!
    var label: UILabel = {
        let label = UILabel()
        //label.text = "This is just testing so don't worry it will look differently"
        //label.layer.borderWidth = 3
        label.numberOfLines = 0
        label.font = label.font.fontWithSize(15)
        label.backgroundColor = UIColor.blackColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    lazy var label1: UILabel = {
        let label = UILabel()
        //label.numberOfLines = 0
        label.text = "\(self.currentNum  + 1) from \(self.total)"
        label.font = label.font.fontWithSize(8)
        label.backgroundColor = UIColor.blackColor()
        label.textColor = UIColor.whiteColor()
       // label.text = "Test"
        return label
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(self.resizeImage(UIImage(named: "export1")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
        button.addTarget(self, action: #selector(ContentViewController.next), forControlEvents: .TouchUpInside)

        print("I added button")
        return button
    }()
    lazy var button1: UIButton = {
        let button = UIButton()
        button.setImage(self.resizeImage(UIImage(named: "export2")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
        button.addTarget(self, action: #selector(ContentViewController.previous(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.draw()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(){
        let v = MyView1()
        let wid = view.frame.size.width
        print("Wid = \(wid)")
        v.lesson = self.lesson
        //v.num = self.num
        view.backgroundColor = UIColor.blackColor()
        view.addSubview(v)
        view.addSubview(label)
        view.addSubview(label1)
        view.addSubview(button)
        view.addSubview(button1)
        label.text = lesson.text
        let h = Cell.Sheight*8+50
        print("Height is \(Cell.Sheight)")
        constrain(view, v, label, label1, button){
            view, v, label, label1, button in
            //label.top == view.top
            //label.width == view.width
            button.top == view.top + 64
            button.width == 30
            button.height == 30
            button.rightMargin == view.rightMargin 
            v.top == view.top + 64
            v.centerX == view.centerX
            v.width == view.width
            //v.height == view.height - 160
            v.height == CGFloat(h)
            label.top == v.bottom + 10
            label.centerX == v.centerX
            label.width == v.width
            label1.top == view.bottom - 10
            label1.width == view.width
            label1.centerX == view.centerX
            
           // button.left == CGFloat(wid - 50)
           // button.left == CGFloat(50)
           // button.centerX == CGFloat(wid - 50)
         //   button.centerX == view.width - 50
            
            
            

        }
        constrain(button1, view){
            button1, view in
            button1.top == view.top + 64
            button1.leftMargin == view.leftMargin
            button1.height == 30
            button1.width == 30
        }
                let defaults = NSUserDefaults.standardUserDefaults()
                if defaults.stringForKey("screenWidth") != nil{
                   // print(w)
                }else{
                    defaults.setFloat(Float(v.frame.size.height), forKey: "screenHeight")
                    defaults.setFloat(Float(v.frame.size.width), forKey: "screenWidth")
                    //print("I am here")
                }

        print("My size is \(label.frame.size.height)")

      //  print(" final \(v.frame.height)")
       // print(" final \(v.frame.width)")

        

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
        print("I am shocked")
        prot.next(currentNum)
    }
    func previous(sender: UIButton){
        print("I am also shocked")
        prot.previous(currentNum)
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
