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
    var height = Float(0)
    var imgHeight: Float!
    var distance: Float!
    var width = Float(0)
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
    var prot: NextPreviousProtcol1!
    
    var lesson:Lesson!
    var currentNum: Int!
    var total:Int!
    lazy var label1: UILabel = {
        let label = UILabel()
        //label.numberOfLines = 0
        label.text = "\(self.currentNum  + 1) из \(self.total)"
        label.font = label.font.fontWithSize(20)
        label.textColor = UIColor.whiteColor()
        // label.text = "Test"
        return label
    }()
    
    //    lazy var button: UIButton = {
    //        let button = UIButton()
    //        button.setImage(self.resizeImage(UIImage(named: "export3")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
    //        button.addTarget(self, action: #selector(WeightViewController.next(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //
    //      //  print("I added button")
    //        return button
    //    }()
    //    lazy var button1: UIButton = {
    //        let button = UIButton()
    //        button.setImage(self.resizeImage(UIImage(named: "export4")!, targetSize: CGSize(width: CGFloat(30), height: CGFloat(30))), forState: .Normal)
    //        button.addTarget(self, action: #selector(ContentViewController.previous(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //
    //        return button
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 247/255, blue: 244/255, alpha: 1)
        height = Float(self.view.frame.height)
        width = Float(self.view.frame.width)/4
        imgHeight = (height - 9*10)/9
        
        //print(imgHeight)
        self.draw()
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button2.layer.cornerRadius = button2.bounds.size.height / 2
        //button3.layer.cornerRadius = button2.bounds.size.height / 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(){
        let p = self.resizeImage(lesson.pieces[0].initPict, targetSize: CGSize(width: CGFloat(100), height: CGFloat(200)))
        let v = UIImageView(image: p)
       // print(p.size.height)
        let green = GreenView()
        green.lesson = lesson
        green.viewWidth = width
        if lesson.pieces[0].color == UIColor.whiteColor(){
            green.img = self.resizeImage(UIImage(named: "wpone")!, targetSize: CGSize(width: CGFloat(imgHeight), height: CGFloat(imgHeight)))
        }else{
            green.img = self.resizeImage(UIImage(named: "bpone")!, targetSize: CGSize(width: CGFloat(imgHeight), height: CGFloat(imgHeight)))
        }
        green.viewHeight = height
        green.imgForKing = self.resizeImage(UIImage(named: "infinity")!, targetSize: CGSize(width: CGFloat(imgHeight), height: CGFloat(imgHeight)))
        let orange = OragneView()
        orange.lesson = lesson
        orange.img = p
        orange.setUp()
       // let tempSize = 3*view.frame.size.height/4
        green.setUP()
        let imgView1 = UIImageView(image: UIImage(named: "equal"))
        
        view.addSubview(v)
        //view.addSubview(label1)
        view.addSubview(orange)
        view.addSubview(green)
        view.addSubview(button2)
        view.addSubview(imgView1)
        view.addSubview(label1)
        // view.addSubview(button3)
        // view.addSubview(button)
        // view.addSubview(button1)
        constrain(view, orange, green, button2, imgView1){
            view, orange, green, button2, button3 in
            orange.top == view.top
            orange.left == view.left
            orange.height == view.height
            orange.width == view.width/2
            green.left == orange.right
            green.top == view.top
            green.bottom == view.bottom
            green.right == view.right
            button2.centerX == view.centerX
            button2.bottom == view.bottom
            button2.height == CGFloat(50)
            button2.width == CGFloat(50)
            button3.centerX == view.centerX
            button3.centerY == view.centerY
            button3.height == CGFloat(50)
            button3.width == CGFloat(50)
            //label1.top == view.top
            //green.height == view.height
            // green.width == view.width/2
            
            
            //v.top == view.top + 64
            //v.centerX == view.centerX
            //  v.height == view.height/4
            
        }
        constrain(view, label1){
            view, label1 in
            label1.top == view.top + 64
            label1.centerX == view.centerX
            // label1.width == CGFloat(50)
            label1.height == CGFloat(20)
        }
        //        let eq = resizeImage(UIImage(named: "equal")!, targetSize:CGSize(width: CGFloat(100), height: CGFloat(100)))
        //        let eqView = UIImageView(image: eq)
        //  eqView.frame = CGRect(x: 100, y: 210, width: 100, height: 100)
        // view.addSubview(eqView)
        //        constrain(view, v, eqView){
        //            view, v, eqView in
        //            eqView.top == v.bottom + 10
        //            eqView.centerX == v.centerX
        //            eqView.height == v.height
        //
        //        }
        
        
        /*      let marginLeft = 0
         
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
         }*/
        
    }
    func resizeImage(image:UIImage, targetSize: CGSize) -> UIImage{
        //     print( self.name)
      //  let size=image.size
        let widthRatio=targetSize.width
        let heightRatio=targetSize.height
        var newSize: CGSize
        // if widthRatio > heightRatio{
        //     newSize=CGSizeMake(size.width*heightRatio, size.height*heightRatio)
        // }else{
        newSize = CGSizeMake(widthRatio,  heightRatio)
        // }
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
