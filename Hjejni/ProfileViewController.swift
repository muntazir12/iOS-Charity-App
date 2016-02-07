//
//  ProfileViewController.swift
//  Hjejni
//
//  Created by Muntazir on 02/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

   
    
    
    override func viewDidLoad() {
        
        let email = NSUserDefaults().stringForKey("email")
        let name = NSUserDefaults().stringForKey("name")
        let type = NSUserDefaults().stringForKey("type")
        
        dispatch_async(dispatch_get_main_queue(), {
        
        self.typeLabel.text = type
        self.emailLabel.text = email
        self.nameLabel.text = name
            
            self.typeLabel.hidden = false
            self.emailLabel.hidden = false
            self.nameLabel.hidden = false
        
        })
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().removeObjectForKey("name");
        NSUserDefaults.standardUserDefaults().removeObjectForKey("email");
        NSUserDefaults.standardUserDefaults().removeObjectForKey("type");
        self.performSegueWithIdentifier("loginView", sender: self);
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.reloadInputViews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self);
        }
        
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
