//
//  UmrahDetailViewController.swift
//  Hjejni
//
//  Created by Muntazir on 31/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class UmrahDetailViewController: UIViewController {
    
    @IBOutlet weak var inputEmail: UILabel!
    @IBOutlet weak var inputStatus: UILabel!
    @IBOutlet weak var inputDependent: UILabel!
    @IBOutlet weak var inputCountry: UILabel!
    @IBOutlet weak var inputFamily: UILabel!
    @IBOutlet weak var inputGender: UILabel!
    @IBOutlet weak var inputAge: UILabel!
    @IBOutlet weak var inputName: UILabel!
    
    var pid: String!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("result:\(pid)")
        
        //Request Data from server
        let request = NSMutableURLRequest(URL: NSURL(string: "http://52.89.129.22/android_login_api/api/get_umrah_ios.php")!)
        request.HTTPMethod = "POST";
        
        let postString = "pid=\(pid!)"
        print("result:\(postString)")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString!)")
            
            
            let myData = responseString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(myData, options: []) as! [String: AnyObject]
                
                if let reposArray = json["umrah"] as? [NSDictionary] {
                    
                    print("result:\(reposArray)")
                    
                    for item in reposArray {
                        
                        let getName = item["name"] as? String
                        let getEmail = item["email"] as? String
                        let getFamily = item["family"] as? String
                        let getGender = item["gender"] as? String
                        let getDependent = item["dependent"] as? String
                        let getStatus = item["status"] as? String
                        let getCountry = item["country"] as? String
                        let getAge = item["age"] as? String
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.inputName.text = getName
                            self.inputGender.text = getGender
                            self.inputFamily.text = getFamily
                            self.inputCountry.text = getCountry
                            self.inputStatus.text = getStatus
                            self.inputDependent.text = getDependent
                            self.inputAge.text = getAge
                            self.inputEmail.text = getEmail
                            
                            self.inputName.hidden = false
                            self.inputGender.hidden = false
                            self.inputFamily.hidden = false
                            self.inputCountry.hidden = false
                            self.inputStatus.hidden = false
                            self.inputAge.hidden = false
                            self.inputDependent.hidden = false
                            
                            
                            
                        })
                        
                        
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        return viewWillAppear(true)
        
        
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let rtable: String = "Umrah"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("sendMessage") as! SendMessageViewController
        viewController.rname = inputName.text
        viewController.remail = inputEmail.text
        viewController.rtable = rtable
        viewController.rpid = pid
        self.presentViewController(viewController, animated: true , completion: nil)
        
    }
    
    @IBAction func previousButtonTapped(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("previousUmrah") as! previousUmrahViewController
        viewController.email = inputEmail.text
        viewController.pid = pid
        self.presentViewController(viewController, animated: true , completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self);
        }
        
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
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
