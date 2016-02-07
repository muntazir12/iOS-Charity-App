//
//  receivedMessageViewController.swift
//  Hjejni
//
//  Created by Muntazir on 01/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class receivedMessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var repositories = [Repository]()
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return repositories.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let userEmail = NSUserDefaults().stringForKey("email")
        
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! messageTableViewCell
        let semail : String = repositories[indexPath.row].semail!
        if(semail == userEmail){
            Cell.nameLabel?.text = repositories[indexPath.row].rname
            Cell.messageLabel?.text = repositories[indexPath.row].message
            Cell.rtableLabel?.text = repositories[indexPath.row].rtable
            Cell.rpidLabel?.text = repositories[indexPath.row].rpid
            Cell.semailLabel?.text = repositories[indexPath.row].semail
            Cell.rnameLabel?.text = repositories[indexPath.row].sname
            Cell.remailLabel?.text = repositories[indexPath.row].remail
            
        }else{
            Cell.hidden = true
        }
        
        return Cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as! messageTableViewCell
        Cell.nameLabel?.text = repositories[indexPath!.row].rname
        Cell.messageLabel?.text = repositories[indexPath!.row].message
        Cell.rtableLabel?.text = repositories[indexPath!.row].rtable
        Cell.rpidLabel?.text = repositories[indexPath!.row].rpid
        Cell.semailLabel?.text = repositories[indexPath!.row].semail
        Cell.rnameLabel?.text = repositories[indexPath!.row].sname
        Cell.remailLabel?.text = repositories[indexPath!.row].remail
        let from = "sent"
        let pid = repositories[indexPath!.row].pid
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("messageDetail") as! messageDetailViewController
        viewController.sname = Cell.nameLabel?.text
        viewController.message = Cell.messageLabel?.text
        viewController.rname = Cell.rnameLabel?.text
        viewController.rtable = Cell.rtableLabel?.text
        viewController.rpid = Cell.rpidLabel?.text
        viewController.semail = Cell.semailLabel?.text
        viewController.remail = Cell.remailLabel?.text
        viewController.from = from
        viewController.pid = pid
        self.presentViewController(viewController, animated: true , completion: nil)
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let userEmail = NSUserDefaults().stringForKey("email")
        
        let semail : String = repositories[indexPath.row].semail!
        if(semail == userEmail){
            return 50.0
        }else{
            return 0.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        // 1
        let reposURL = NSURL(string: "http://52.89.129.22/android_login_api/api/get_all_message.php")
        // 2
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            // 3
            do{
                if let json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? NSDictionary {
                    // 4
                    if let reposArray = json["message"] as? [NSDictionary] {
                        
                        // 5
                        for item in reposArray {
                            repositories.append(Repository(json: item))
                            
                        }
                    }
                }
            }
            catch let error as NSError {
                print(error)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    
}


