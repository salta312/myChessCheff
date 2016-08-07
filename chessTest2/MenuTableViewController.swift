//
//  MenuTableViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol MenuTableViewControllerDelegate {
    func didSelectViewController(vc: UIViewController)
}

class MenuTableViewController: UITableViewController {
    var arr = [String]()
    var problems = [Problems]()
    var delegate: MenuTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tableView.registerClass(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
       // var task = TableTask()
        arr.append("Lesson 1")
        arr.append("Lesson 2")
        arr.append("Problems")
        arr.append("news")
       // task.lessons =

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
       // print("I am calling you")
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     //   let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "reuseIdentifier") as! MyTableViewCell
       // let cell : MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! MyTableViewCell

        let cell = MyTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "reuseIdentifier")
        //let cell = UITableViewCell(
        cell.textLabel!.text = self.arr[indexPath.row]
        //print(self.arr[indexPath.row])

        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row)
        if indexPath.row == 0{
            let vc: LessonsViewController = LessonsViewController()
            delegate?.didSelectViewController(vc)
//            self.presentViewController(vc, animated: true, completion: nil)

        }else if indexPath.row == 1{
            let vc: WeightLessonViewController = WeightLessonViewController()
            delegate?.didSelectViewController(vc)
//            self.presentViewController(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            SVProgressHUD.show()
            loadProblemsAssync()
            
        }else if indexPath.row == 3{
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            let vc: TwitterNewsCollectionViewController = TwitterNewsCollectionViewController(collectionViewLayout: layout)
            delegate?.didSelectViewController(vc)
        }
    }
    //MARK: -Backendless
    //what should you do if there is no internet connection
    func loadProblemsAssync(){
        let dataStore = Backendless.sharedInstance().data.of(Problems.ofClass())
        dataStore.find(
            { (result: BackendlessCollection!) -> Void in
                //     print("I am here")
                let probs = result.getCurrentPage()
                //     print(cities)
                for obj in probs {
                    //print(obj)
                    let prob=obj as! Problems
                    // print(city.title)
                    self.problems.append(prob)
                      //print(prob.composition)
                }
                let vc = ProblemViewController()
                vc.problems = self.problems
                SVProgressHUD.dismiss()
                self.delegate?.didSelectViewController(vc)
                
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
