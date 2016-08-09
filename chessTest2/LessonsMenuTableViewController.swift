//
//  LessonsMenuTableViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 8/4/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Cartography

class LessonsMenuTableViewController: UITableViewController {
    var arr = [String]()
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 128
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.title = "Close"
        leftBarButtonItem.target = self
        leftBarButtonItem.action = #selector(barButtonItemClicked(_:))
        self.navigationItem.rightBarButtonItem = leftBarButtonItem
        navigationItem.title = "Уроки"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1/255, green: 152/255, blue: 215/255, alpha: 1)
        arr.append("Как ходят фигуры")
        arr.append("Ценность фигур")
        arr.append("Дополнительный материал")
        images.append(UIImage(named: "number-1")!)
        images.append(UIImage(named: "number-two")!)
        images.append(UIImage(named: "number-3")!)
        
        

    }
    func barButtonItemClicked(button: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = arr[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        
        //    cell.title = arr[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // print(indexPath.row)

        if indexPath.row == 0{
            let vc = UINavigationController(rootViewController: LessonsViewController())
            self.presentViewController(vc, animated: true, completion: nil)
            
        }else if indexPath.row == 1{
          //  print("no I am here")
            let vc = UINavigationController(rootViewController: WeightLessonViewController())
            self.presentViewController(vc, animated: true, completion: nil)
            
            //delegate?.didSelectViewController(vc)
            //            self.presentViewController(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            let vc = UINavigationController(rootViewController: AdditionalLessonsViewController())
            self.presentViewController(vc, animated: true, completion: nil)
            
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
