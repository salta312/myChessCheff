//
//  RegisterViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/12/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography
import Navajo_Swift

class RegisterViewController: UIViewController {
    
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
    let username: UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.textAlignment = NSTextAlignment.Center
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.spellCheckingType = UITextSpellCheckingType.No
        textField.autocorrectionType = UITextAutocorrectionType.No
        return textField
    }()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
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
            
            view.addSubview(username)
            view.addSubview(emailLabel)
            view.addSubview(passwordLabel)
            view.addSubview(register)
            constrain(imgView, emailLabel, passwordLabel, username, register){
                imgView, emailLabel, passwordLabel, username, register in
                username.width == imgView.width
                username.centerX == imgView.centerX
                username.centerY == imgView.bottom + 1/10*height
                emailLabel.centerX == username.centerX
                emailLabel.width == username.width
                emailLabel.centerY == username.bottom + 1/15*height
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
            view.addSubview(username)
            view.addSubview(emailLabel)
            view.addSubview(passwordLabel)
            view.addSubview(register)
            constrain( emailLabel, passwordLabel, username, register){
                 emailLabel, passwordLabel, username, register in
                username.width == width-100
                username.centerX == username.superview!.centerX
                username.centerY == username.superview!.centerY*1/10 + 64
                emailLabel.centerX == username.centerX
                emailLabel.width == username.width
                emailLabel.centerY == username.bottom + 1/15*height
                passwordLabel.centerX == emailLabel.centerX
                passwordLabel.width == emailLabel.width
                passwordLabel.centerY == emailLabel.bottom + 1/15*height
                register.centerX == passwordLabel.centerX
                register.width == passwordLabel.width
                register.centerY == passwordLabel.bottom + 1/15*height
                
            }

        

 
        }
        register.addTarget(self, action: #selector(RegisterViewController.submitPressed(_:)), forControlEvents: .TouchUpInside)

        

        
    }
    func submitPressed(sender: UIButton!){
      //  print("He pressed me")
        guard let email=emailLabel.text else{
            callAlert("no email")
            return
        }
        guard let password=passwordLabel.text else{
            callAlert("no password")
            return
        }
        guard let username = username.text else{
            callAlert("no username")
            return

        }
        let lengthRule=NJOLengthRule(min: 6, max: 24)
        let upperCaseRule=NJORequiredCharacterRule(preset: .LowercaseCharacter)
        let validator = NJOPasswordValidator(rules: [lengthRule, upperCaseRule])
        let failingRules=validator.validatePassword(password)
        let failingRules2 = validator.validatePassword(username)
        if self.validateEmail(email) != true{
            callAlert("email error")
            return
            
        }
        if failingRules != nil{
            callAlert("password is not safe")
            return
        }
        if failingRules2 != nil{
            callAlert("username should contain at least 6 characters and it should include letters")
            return
        }
        self.registerUserAsync(email, password: password, username: username)


       // print("The email is \(email)")

        
        
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
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    func registerUserAsync(email:String, password:String, username: String) {
        
        let user = BackendlessUser()
        user.email = email
        user.setProperty("username", object: username)
       // user.
        user.password = password
        
        Backendless.sharedInstance().userService.registering(user,
                                                             response: { (registeredUser : BackendlessUser!) -> () in
                                                                print("User has been registered (ASYNC): \(registeredUser)")
                                                                self.loginUserAsync(email, password: password)
            },
                                                             error: { ( fault : Fault!) -> () in
                                                                print("Server reported an error: \(fault)")
                                                                self.callAlert("\(fault)")
            }
        )
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
