//
//  SideNavigationViewController.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/15/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import Cartography

class SideNavigationViewController: ENSideMenuNavigationController {
   // var viewControllers:[UIViewController()]!
    init(){
      // super.init(coder: NSCode)

        super.init(menuViewController: LessonsViewController(), contentViewController: nil)
        
        let menu = MenuTableViewController()
        menu.delegate = self
        //menu.view.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menu, menuPosition: ENSideMenuPosition.Left)
        sideMenu!.menuWidth = 180
        view.bringSubviewToFront(navigationBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //let navItem = UINavigationItem(title: "Menu")
        //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "selector");
        //navItem.leftBarButtonItem = doneItem;
      //  let doneItem = UIBarButtonItem.initWithTitle()
       // self.setToolbarItems([navItem], animated: true)





        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension SideNavigationViewController: MenuTableViewControllerDelegate {
    func didSelectViewController(vc: UIViewController) {
        sideMenuController()?.setContentViewController(vc)
    }
}
