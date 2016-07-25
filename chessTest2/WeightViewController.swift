//
//  WeightViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class WeightViewController: UIViewController {
    var prot: NextPreviousProtcol1!

    var lesson:Lesson!
    var currentNum: Int!
    var total:Int!
    lazy var label1: UILabel = {
        let label = UILabel()
        //label.numberOfLines = 0
        label.text = "\(self.currentNum  + 1) from \(self.total)"
        label.font = label.font.fontWithSize(8)
        // label.text = "Test"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(self.resizeImage(UIImage(named: "export3")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
        button.addTarget(self, action: #selector(WeightViewController.next(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
      //  print("I added button")
        return button
    }()
    lazy var button1: UIButton = {
        let button = UIButton()
        button.setImage(self.resizeImage(UIImage(named: "export4")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
        button.addTarget(self, action: #selector(ContentViewController.previous(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 247/255, blue: 244/255, alpha: 1)
        self.draw()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(){
 //       print("I am drawing it")
//        var myImage: UIImage = UIImage(named: "original")
//        if lesson.pieces[0].name == "queen"{
//            
//            if lesson.pieces[0].color == UIColor.whiteColor(){
//            myImage = self.resizeImage(UIImage(named: "wqueen")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }else{
//            myImage = self.resizeImage(UIImage(named: "bqueen")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }
//        }else if lesson.pieces[0].name == "rock"{
//            if lesson.pieces[0].color == UIColor.whiteColor(){
//                myImage = self.resizeImage(UIImage(named: "wrock")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }else{
//                myImage = self.resizeImage(UIImage(named: "brock")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//
//            }}else if lesson.pieces[0].name == "bishop"{
//            if lesson.pieces[0].color == UIColor.whiteColor(){
//                myImage = self.resizeImage(UIImage(named: "bishop")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }else{
//                myImage = self.resizeImage(UIImage(named: "bbishop")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//                
//            }
//            
//        }else if lesson.pieces[0].name == "knight"{
//            if lesson.pieces[0].color == UIColor.whiteColor(){
//                myImage = self.resizeImage(UIImage(named: "wknight")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }else{
//                myImage = self.resizeImage(UIImage(named: "bknight")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//                
//            }
//            
//        }else if lesson.pieces[0].name == "pone"{
//            if lesson.pieces[0].color == UIColor.whiteColor(){
//                myImage = self.resizeImage(UIImage(named: "wpone")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//            }else{
//                myImage = self.resizeImage(UIImage(named: "bpone")!, targetSize: CGSize(width: CGFloat(50), height: CGFloat(50)))
//                
//            }
//        }else{
//            //myImage = UIImage(named: "original")
//        }
       // lesson.pieces[0].initPict
        let p = self.resizeImage(lesson.pieces[0].initPict, targetSize: CGSize(width: CGFloat(100), height: CGFloat(100)))
        let v = UIImageView(image: p)
        
//        if myImage != nil{
//            var v = UIImageView(image: myImage)
//        }else{
//            var v = UIImageView(image: p)
//        }
       // v.frame = CGRect(x: 100,y: 100,width: 100,height: 100)
        
        let tempSize = 3*view.frame.size.height/4

        view.addSubview(v)
        view.addSubview(button)
        view.addSubview(button1)
        constrain(view, v, button, button1){
            view, v, button, button1 in
            button.rightMargin == view.rightMargin
            button.height == 30
            button.width == 30
            button.top == view.top + 64
            button1.leftMargin == view.leftMargin
            button1.height == 30
            button1.width == 30
            button1.top == view.top + 64
            v.top == view.top + 64
            v.centerX == view.centerX
            v.height == view.height/4
            
        }
        let eq = resizeImage(UIImage(named: "equal")!, targetSize:CGSize(width: CGFloat(100), height: CGFloat(100)))
        let eqView = UIImageView(image: eq)
      //  eqView.frame = CGRect(x: 100, y: 210, width: 100, height: 100)
        view.addSubview(eqView)
        constrain(view, v, eqView){
            view, v, eqView in
            eqView.top == v.bottom + 10
            eqView.centerX == v.centerX
            eqView.height == v.height
            
        }

        
        let marginLeft = 0
        
        if lesson.pieces[0].name != Pieces.king{
            var temp = 0
            if lesson.pieces[0].weight == 5{
                temp = 50
            }else if lesson.pieces[0].weight <= 3{
                temp = 100
            }
            //var view1 = CustomPoneView
        for index in 1...lesson.pieces[0].weight{
            if lesson.pieces[0].color == UIColor.whiteColor(){
            let im = resizeImage(UIImage(named:"wpone")!, targetSize: CGSize(width:CGFloat(20), height:CGFloat(50)))
            let imgV = UIImageView(image: im)
            imgV.frame = CGRect(x:temp+50+index*20 + marginLeft, y:Int(tempSize), width:20, height:50)
            view.addSubview(imgV)
                
                
            }else{
                let im = resizeImage(UIImage(named:"bpone")!, targetSize: CGSize(width:CGFloat(20), height:CGFloat(50)))
                let imgV = UIImageView(image: im)
                imgV.frame = CGRect(x:temp+50+index*20, y:Int(tempSize), width:20, height:50)
                view.addSubview(imgV)
            }
        }
        }else{
            let im = resizeImage(UIImage(named:"infinity")!, targetSize: CGSize(width:CGFloat(300), height:CGFloat(100)))
            let imgV = UIImageView(image: im)
            imgV.frame = CGRect(x: 70, y:Int(tempSize), width:200, height:100)
            view.addSubview(imgV)
        }
        view.addSubview(label1)
        constrain(view, label1){
            view, label1 in
            label1.top == view.bottom - 10
            label1.width == view.width
            label1.centerX == view.centerX
        }

    }
    func resizeImage(image:UIImage, targetSize: CGSize) -> UIImage{
   //     print( self.name)
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
    
    func next(sender: UIButton) {
      //  print("I am shocked")
        prot.next(currentNum)
    }
    func previous(sender: UIButton){
     //   print("I am also shocked")
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
