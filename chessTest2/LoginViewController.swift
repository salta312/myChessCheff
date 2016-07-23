//
//  LoginViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/12/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography
import Navajo_Swift

class LoginViewController: UIViewController {
    let emailLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.textAlignment = NSTextAlignment.Center
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.spellCheckingType = UITextSpellCheckingType.No
        textField.autocorrectionType = UITextAutocorrectionType.No
        return textField
        
    }()
    let passwordLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.textAlignment = NSTextAlignment.Center
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.spellCheckingType = UITextSpellCheckingType.No
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.secureTextEntry = true
        
        return textField
    }()
    let register: UIButton = {
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


    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor(red: 249/255, green: 247/255, blue: 244/255, alpha: 1)
        self.draw()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func draw(){
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        if height>500{
            var imageHeight = height / 10
            if height > 570{
                imageHeight = height/5
            }
            let imageWidth = width - 100
            let img = resizeImage(UIImage(named: "original")!, targetSize: CGSize(width: imageWidth, height: imageHeight))
            let imgView = UIImageView(image: img)
            imgView.frame = CGRect(x: 0, y: 64, width: imageWidth, height: imageHeight)
            //print("My height \(height)")
            //print "\(height)"
            // print" \(view.center.x;) \(height/2 - imageHeight - 100;) \(imageWidth;) \(imageHeight;)"
            view.addSubview(imgView)
            imgView.center.x = view.center.x
            
            view.addSubview(emailLabel)
            view.addSubview(passwordLabel)
            view.addSubview(register)
            constrain(imgView, emailLabel, passwordLabel, register){
                imgView, emailLabel, passwordLabel, register in
                emailLabel.width == imgView.width
                emailLabel.centerX == imgView.centerX
                emailLabel.centerY == imgView.bottom + 1/10*height
                passwordLabel.centerX == emailLabel.centerX
                passwordLabel.width == emailLabel.width
                passwordLabel.centerY == emailLabel.bottom + 1/15*height
                register.centerX == passwordLabel.centerX
                register.width == passwordLabel.width
                register.centerY == passwordLabel.bottom + 1/15*height
                
            }
        }else{
            
            //      let frame = CGRect(x: imgView.frame.origin.x, y: imgView.frame.origin.y, width: imgView.frame.width, height: imgView.frame.height)
            //   imgView.frame = frame
            view.addSubview(emailLabel)
            view.addSubview(passwordLabel)
            view.addSubview(register)
            constrain( emailLabel, passwordLabel, register){
                emailLabel, passwordLabel, register in
                emailLabel.width == width-100
                emailLabel.centerX == emailLabel.superview!.centerX
                emailLabel.centerY == emailLabel.superview!.centerY*1/10 + 64
                passwordLabel.centerX == emailLabel.centerX
                passwordLabel.width == emailLabel.width
                passwordLabel.centerY == emailLabel.bottom + 1/15*height
                register.centerX == passwordLabel.centerX
                register.width == passwordLabel.width
                register.centerY == passwordLabel.bottom + 1/15*height
                
            }
            
            
            
            
        }
        register.addTarget(self, action: #selector(LoginViewController.submitPressed(_:)), forControlEvents: .TouchUpInside)
        
        
        
        
    }
    func submitPressed(sender: UIButton!){
        //print("He pressed me")
        guard let email=emailLabel.text else{
            callAlert("no email")
            return
        }
        guard let password=passwordLabel.text else{
            callAlert("no password")
            return
                
        }
        self.loginUserAsync(email, password: password)
        
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
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func callAlert(message:String!){
        let alertController=UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKButton=UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loginUserAsync(email:String, password:String) {
        Backendless.sharedInstance().userService.setStayLoggedIn( true )
        Backendless.sharedInstance().userService.login(
            email, password:password,
            response: { ( user : BackendlessUser!) -> () in
                print("User has been logged in (ASYNC): \(user)")
                let less = LessonsViewController()
                let nav1 = SideNavigationViewController()
                nav1.viewControllers = [less]
                self.presentViewController(nav1, animated: true, completion: nil)
                
                
            },
            error: { ( fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
                self.callAlert("Server reported an error: \(fault)")

            }
        )
    }
    
}
