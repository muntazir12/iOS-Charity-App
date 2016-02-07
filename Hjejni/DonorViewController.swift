//
//  DonorViewController.swift
//  Hjejni
//
//  Created by Muntazir on 28/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class DonorViewController: UIViewController, UISearchDisplayDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newDonor: UIBarButtonItem!
    
    var repositories = [HajRepository]()
    var filtered = [HajRepository]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Getting Data From NSUserDefault
        let userType = NSUserDefaults().stringForKey("type")
        
        if (userType == "Beneficial"){
            newDonor.enabled = false;
        }
        
        self.searchDisplayController!.searchResultsTableView.rowHeight = tableView.rowHeight;
        return GetData()
        
    }
    
    func GetData(){

        // 1
        let reposURL = NSURL(string: "http://52.89.129.22/android_login_api/api/get_all_donor.php")
        // 2
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            // 3
            
            
            do{
                if let json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? NSDictionary {
                    // 4
                    
                    if let reposArray = json["donor"] as? [NSDictionary] {
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController!.searchResultsTableView {
            return filtered.count
        } else {
            return repositories.count
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! hajTableViewCell
        
        var reposit : HajRepository
        // Check to see whether the normal table or search results table is being displayed and set the HajRepository object from the appropriate array
        if tableView == searchDisplayController!.searchResultsTableView {
            reposit = filtered[indexPath.row]
        } else {
            reposit = repositories[indexPath.row]
        }
        
        Cell.nameLabel?.text = reposit.name
        Cell.emailLabel?.text = reposit.email
        Cell.countryLabel?.text = reposit.country
        Cell.pidLabel?.text = reposit.pid
        return Cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        
        // Get Cell Detail
        let rtable: String = "Donor"
        let indexPath = tableView.indexPathForSelectedRow;
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as! hajTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (tableView == self.searchDisplayController?.searchResultsTableView) {
            Cell.nameLabel.text = filtered[indexPath!.row].name
            Cell.emailLabel.text = filtered[indexPath!.row].email
            Cell.pidLabel?.text = filtered[indexPath!.row].pid
        }else{
            Cell.nameLabel.text = repositories[indexPath!.row].name
            Cell.emailLabel.text = repositories[indexPath!.row].email
            Cell.pidLabel?.text = repositories[indexPath!.row].pid
        }
        
        let viewController = storyboard.instantiateViewControllerWithIdentifier("sendMessage") as! SendMessageViewController
        viewController.rname = Cell.nameLabel.text
        viewController.rtable = rtable
        viewController.remail = Cell.emailLabel.text
        viewController.rpid = Cell.pidLabel.text
        
        self.presentViewController(viewController, animated: true , completion: nil)
        
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        filtered = repositories.filter({( repos: HajRepository) -> Bool in
            let nameMatch = repos.name?.rangeOfString(searchText)
            let countryMatch = repos.country?.rangeOfString(searchText)
            return (nameMatch != nil) || (countryMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        filterContentForSearchText(searchString!)
        tableView.rowHeight = 62.0
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        filterContentForSearchText(searchDisplayController!.searchBar.text!)
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
