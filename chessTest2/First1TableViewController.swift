//
//  First1TableViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import SVProgressHUD


class First1TableViewController: UITableViewController {
    var arr = [String]()
    var images = [UIImage]()
    var problems = [Problems]()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 128
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
            SVProgressHUD.show()
            loadProblemsAssync()


            //delegate?.didSelectViewController(vc)
            //            self.presentViewController(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            //else if indexPath.row == 2{
               // print("I am here")
                let layout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = 0
            //let vc = UINavigationController(rootViewController: WeightLessonViewController())
                let vc = UINavigationController(rootViewController: TwitterNewsCollectionViewController(collectionViewLayout: layout))
                self.presentViewController(vc, animated: true, completion: nil)
           // }
        }
    }
    func loadProblemsAssync(){
        let dataStore = Backendless.sharedInstance().data.of(Problems.ofClass())
        dataStore.find(
            { (result: BackendlessCollection!) -> Void in
                //     print("I am here")
                let probs = result.getCurrentPage()
                //     print(cities)
                self.problems = probs as! [Problems]
                let vc = ProblemViewController()
                vc.problems = self.problems
                SVProgressHUD.dismiss()
               // self.delegate?.didSelectViewController(vc)
                let vc1 = UINavigationController(rootViewController: vc)
                self.presentViewController(vc1, animated: true, completion: nil)
                
                //self.tableView.reloadData()
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error: \(fault)")
                SVProgressHUD.dismiss()
                self.callAlert("Server reported an error: \(fault)")
                
        })
        
    }
    func callAlert(message:String!){
        let alertController=UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKButton=UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKButton)
        self.presentViewController(alertController, animated: true, completion: nil)
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
