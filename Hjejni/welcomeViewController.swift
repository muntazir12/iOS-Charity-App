//
//  welcomeViewController.swift
//  Hjejni
//
//  Created by Muntazir on 02/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = NSUserDefaults().stringForKey("name")
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            self.nameLabel.text = name
            self.nameLabel.hidden = false
            
        })

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
