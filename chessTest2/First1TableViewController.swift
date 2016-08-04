//
//  First1TableViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class First1TableViewController: UITableViewController {
    var arr = [String]()
    var images = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()
        arr.append("Уроки")
        arr.append("Задачи")
        arr.append("Новости")
        images.append(UIImage(named: "books")!)
        images.append(UIImage(named: "brain")!)
        images.append(UIImage(named: "tv")!)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = arr[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        
    //    cell.title = arr[indexPath.row]

        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            let vc = UINavigationController(rootViewController: LessonsMenuTableViewController())
            self.presentViewController(vc, animated: true, completion: nil)
            
            
            
        }else if indexPath.row == 1{
            let vc = UINavigationController(rootViewController: LessonsMenuTableViewController())
            self.presentViewController(vc, animated: true, completion: nil)

            //delegate?.didSelectViewController(vc)
            //            self.presentViewController(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
           // SVProgressHUD.show()
           // loadProblemsAssync()
           //
        }else if indexPath.row == 3{
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            let vc: TwitterNewsCollectionViewController = TwitterNewsCollectionViewController(collectionViewLayout: layout)
           // delegate?.didSelectViewController(vc)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
