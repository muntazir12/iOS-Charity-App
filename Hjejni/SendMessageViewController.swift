//
//  SendMessageViewController.swift
//  Hjejni
//
//  Created by Muntazir on 31/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController {
    
    @IBOutlet weak var inputMessage: UITextField!
    
    var remail: String?
    var rtable: String?
    var rpid: String?
    var rname: String?
    
    let semail = NSUserDefaults().stringForKey("email")
    let sname = NSUserDefaults().stringForKey("name")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("result=\(remail)")
        print("result=\(rtable)")
        print("result=\(rpid)")
        print("result=\(semail)")
        print("result=\(sname)")
        print("result=\(rname)")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
       let message = inputMessage.text
        
        //Check Empty Fields
        if(message!.isEmpty)
        {
            //Display Alert Message
            
            displayMyAlertMessage("All fields are required!");
            return;
            
        }
        
        
        
        //Store Data to server
        let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/create_message.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.HTTPMethod = "POST";
        
        
        
        let postString = "remail=\(remail!)&rname=\(rname!)&rpid=\(rpid!)&rtable=\(rtable!)&semail=\(semail!)&sname=\(sname!)&message=\(message!)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        //Execute Task
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                if let myData = data, let json = try NSJSONSerialization.JSONObjectWithData(myData, options: .MutableContainers) as? NSDictionary {
                    
                    
                    let resultValue = json["success"] as? Int
                    print("result:\(resultValue!)")
                    
                    var isUserRegistered:Bool = false;
                    if(resultValue == 0) { isUserRegistered=false; }
                    var messageToDisplay:String = json["message"] as! String!;
                    if(isUserRegistered)
                    {
                        messageToDisplay = json["message"] as! String!;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //Display Alert Message With Confirmation
                        let myAlert = UIAlertController(title: "Message", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { action in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated:true, completion:nil);
                    });
                    
                }
            }
            catch let error as NSError {
                print(error)
            }
        }
        
        task.resume()
        
        //Display Confirmation Message
    }
    
    func displayMyAlertMessage (userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated:true, completion:nil);
        
        
        
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
