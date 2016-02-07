//
//  previousUmrahViewController.swift
//  Hjejni
//
//  Created by Muntazir on 03/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class previousUmrahViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var repositories = [HajRepository]()
    
    var email: String?
    var pid: String?
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! hajTableViewCell
        if (email == repositories[indexPath.row].email && pid != repositories[indexPath.row].pid){
            Cell.nameLabel?.text = repositories[indexPath.row].name
            Cell.countryLabel?.text = repositories[indexPath.row].country
            Cell.dobLabel?.text = repositories[indexPath.row].dob
            Cell.pidLabel?.text = repositories[indexPath.row].pid
        }else{
            Cell.hidden = true
        }
        return Cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as! hajTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        Cell.pidLabel.text = repositories[indexPath!.row].pid
        let viewController = storyboard.instantiateViewControllerWithIdentifier("umrahDetail") as! UmrahDetailViewController
        viewController.pid = Cell.pidLabel.text
        self.presentViewController(viewController, animated: true , completion: nil)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        let remail : String = repositories[indexPath.row].email!
        let rpid : String = repositories[indexPath.row].pid!
        if(remail == email && rpid != pid){
            return 63.0
        }else{
            return 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print ("result=\(pid)")
        
        //Getting Data From NSUserDefault
        
        
        // 1
        let reposURL = NSURL(string: "http://52.89.129.22/android_login_api/api/get_all_umrah.php")
        // 2
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            // 3
            do{
                if let json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? NSDictionary {
                    // 4
                    if let reposArray = json["umrah"] as? [NSDictionary] {
                        // 5
                        for item in reposArray {
                            repositories.append(HajRepository(json: item))
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
