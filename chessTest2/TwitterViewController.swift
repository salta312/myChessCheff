//
//  TwitterViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/2/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: TWTRTimelineViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Base this Tweet ID on some data from elsewhere in your app
        let client = TWTRAPIClient()
        //TODO: Replace with your collection id or a different data source
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: "chesscom", APIClient: client)
        self.dataSource = TWTRUserTimelineDataSource(screenName: "ChessKazakh", APIClient: client)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       // self.showTimeline()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func showTimeline() {
        // Create an API client and data source to fetch Tweets for the timeline
        let client = TWTRAPIClient()
        //TODO: Replace with your collection id or a different data source
        let dataSource = TWTRCollectionTimelineDataSource(collectionID: "539487832448843776", APIClient: client)
        // Create the timeline view controller
        let timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
        // Create done button to dismiss the view controller
        let button = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismissTimeline))
        timelineViewControlller.navigationItem.leftBarButtonItem = button
        // Create a navigation controller to hold the
        let navigationController = UINavigationController(rootViewController: timelineViewControlller)
        showDetailViewController(navigationController, sender: self)
    }
    func dismissTimeline() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
