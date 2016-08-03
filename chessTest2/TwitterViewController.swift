//
//  TwitterViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/2/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import TwitterKit
import OAuthSwift

class TwitterViewController: OAuthViewController{
    var oauthswift: OAuthSwift?
 //   let formData = Semaphore<TwitterViewController>()



    override func viewDidLoad() {
        super.viewDidLoad()
//        let oauthswift = OAuth2Swift(
//            consumerKey:    "NtSw75uvVzM4t0rTQzgH9ZtaN",         // 2 Enter google app settings
//            consumerSecret: "uFZxbFx7LcrvleoNht6Y5oXkBpukwzyjhbMaC9Gm7vt8yMP9ov",
//            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
//            accessTokenUrl:  "https://api.twitter.com/oauth/access_token",
//            responseType:   "code"
//        )
//        oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/twitter")!, scope: "http://twitter.com", state: "", success: { (credential, response, parameters) in
//            print("sucess")
//            self.testTwitter(oauthswift)
//            }) { (error) in
//                print("failure")
//        }
        
        
//                let oauthswift = OAuth1Swift(
//                    consumerKey:    "NtSw75uvVzM4t0rTQzgH9ZtaN",
//                    consumerSecret: "uFZxbFx7LcrvleoNht6Y5oXkBpukwzyjhbMaC9Gm7vt8yMP9ov",
//                    requestTokenUrl: "https://api.twitter.com/oauth/request_token",
//                    authorizeUrl:    "https://api.twitter.com/oauth/authorize",
//                    accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
//                )
//                oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/twitter")!, success: { (credential, response, parameters) in
//                    print("sucess")
//                    }) { (error) in
//                        print("failure")
//        }
                //self.oauthswift = oauthswift
                //print(oauthswift)
              //  oauthswift.authorize_url_handler = get_url_handler()
//                oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/twitter")!, success: {
//                    credential, response, parameters in
//                    print("I am here")
//                    //self.showTokenAlert(serviceParameters["name"], credential: credential)
//                   // self.testTwitter(oauthswift)
//                    }, failure: { error in
//                        print(error.localizedDescription)
//                    }
//                )
        
        
//        let oauthswift = OAuth1Swift(
//            consumerKey:    "Hbu9ERhR6qdCkVuV2UZcJFNre",
//            consumerSecret: "IFrGqk2Xg0TcsF45suPrvAiSz3wjR8WEyFRoh8gRLKs6faFpuZ",
//            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
//            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
//            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
//        )
//        print(oauthswift)
//        oauthswift.authorizeWithCallbackURL(
//            NSURL(string: "chesscheff://twitter")!,
//            success: { credential, response, parameters in
//                print(credential.oauth_token)
//                print(credential.oauth_token_secret)
//                print(parameters["user_id"])
//            },
//            failure: { error in
//                print(error.localizedDescription)
//            }             
//        )
        //let swifter = Swifter(account: "twitterAccount")
/*        swifter.authorizeWithCallbackURL(URL(string:"")!, success: { accessToken, response in
            // ...
            print("sucess")
            }, failure: { error in
                print("failure")
                
                // ...
                
        })*/
        let swifter = Swifter(consumerKey: "Hbu9ERhR6qdCkVuV2UZcJFNre", consumerSecret: "IFrGqk2Xg0TcsF45suPrvAiSz3wjR8WEyFRoh8gRLKs6faFpuZ")
        swifter.authorizeWithCallbackURL(NSURL(string: "http://twitter.com")!, presentFromViewController: self, success: { (accessToken, response) in
            print("sucess")
            self.callAlert("sucess")
            }) { (error) in
                print(error)
                self.callAlert("\(error)")

        }
 //       swifter.authoriz
//        let swifter = Swifter(consumerKey: "Hbu9ERhR6qdCkVuV2UZcJFNre", consumerSecret: "IFrGqk2Xg0TcsF45suPrvAiSz3wjR8WEyFRoh8gRLKs6faFpuZ")
//        swifter.getStatusesHomeTimelineWithCount(20, success: { statuses in
//            // ...
//            print("sucess")
//            
//            }, failure: { error in
//                // ...
//                print("failure")
//                
//        })



    }
    func testTwitter(oauthswift: OAuth2Swift) {
        print("I am here")
        oauthswift.client.get("https://api.twitter.com/1.1/statuses/mentions_timeline.json", parameters: [:],
                              success: {
                                data, response in
                                let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                                print(jsonDict)
            }, failure: { error in
                print(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       // self.showTimeline()
    }
//    func get_url_handler() -> OAuthSwiftURLHandlerType {
//        guard let type = self.formData.data?.handlerType else {
//            return OAuthSwiftOpenURLExternally.sharedInstance
//        }
//        switch type {
//        case .External :
//            return OAuthSwiftOpenURLExternally.sharedInstance
//        case .Internal:
//            let url_handler = internalWebViewController
//            self.addChildViewController(url_handler) // allow WebViewController to use this ViewController as parent to be presented
//            return url_handler
//        case .Safari:
//            #if os(iOS)
//                if #available(iOS 9.0, *) {
//                    let handler = SafariURLHandler(viewController: self, oauthSwift: self.oauthswift!)
//                    handler.presentCompletion = {
//                        print("Safari presented")
//                    }
//                    handler.dismissCompletion = {
//                        print("Safari dismissed")
//                    }
//                    return handler
//                }
//            #endif
//            return OAuthSwiftOpenURLExternally.sharedInstance
//        }
//        
//
//    }
    func callAlert(message:String!){
        let alertController=UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKButton=UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
