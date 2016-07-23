//
//  ViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/11/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 249/255, green: 247/255, blue: 244/255, alpha: 1)
       // view.backgroundColor = UIColor.redColor()
        self.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func draw(){
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        let imageHeight = height / 3
        let imageWidth = width - 100
        let img = resizeImage(UIImage(named: "original")!, targetSize: CGSize(width: imageWidth, height: imageHeight))
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
       // print" \(view.center.x;) \(height/2 - imageHeight - 100;) \(imageWidth;) \(imageHeight;)"
        view.addSubview(imgView)
        imgView.center = view.center
        let frame = CGRect(x: imgView.frame.origin.x, y: imgView.frame.origin.y - 100, width: imgView.frame.width, height: imgView.frame.height)
        imgView.frame = frame
        let register: UIButton = {
            let button = UIButton()
            button.setTitle("Register", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitleColor(.grayColor(), forState: .Highlighted)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.cornerRadius = 10
            //button.titleLabel!.text = "submit"
            //print("")
            return button
        }()
        let login: UIButton = {
            let button = UIButton()
            button.setTitle("Login", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitleColor(.grayColor(), forState: .Highlighted)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.cornerRadius = 10
            //button.titleLabel!.text = "submit"
            //print("")
            return button
        }()
//        let loginWiThVK: UIButton = {
//            let button = UIButton()
//            //button.setImage(UIImage(named: "v.png"), forState: .Normal)
//            button.setTitle("Login with VK", forState: UIControlState.Normal)
//            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
//            button.setTitleColor(.grayColor(), forState: .Highlighted)
//            button.layer.borderWidth = 2
//            button.layer.borderColor = UIColor.blackColor().CGColor
//            button.layer.cornerRadius = 10
//            //button.titleLabel!.text = "submit"
//            //print("")
//            return button
//        }()
        register.addTarget(self, action: #selector(ViewController.pressed(_:)), forControlEvents: .TouchUpInside)
        login.addTarget(self, action: #selector(ViewController.pressed(_:)), forControlEvents: .TouchUpInside)

        view.addSubview(register)
        view.addSubview(login)
    //    view.addSubview(loginWiThVK)
        constrain(imgView, register, login){
            imgView, register, login in
            register.width == imgView.width
            register.centerX == imgView.centerX
            register.centerY == imgView.bottom + 1/10*height
            login.centerX == register.centerX
            login.width == register.width
            login.centerY == register.bottom + 1/15*height
//            loginWiThVK.centerX == register.centerX
//            loginWiThVK.width == register.width
//            loginWiThVK.centerY == login.bottom + 1/15*height
        }
        
    }
    func pressed(sender: UIButton!) {
        // do some stuff
        //print("yourButton was pressed")
        if sender.currentTitle == "Register"{
        
            let vc = RegisterViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if sender.currentTitle == "Login"{
            let vc = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
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


}

