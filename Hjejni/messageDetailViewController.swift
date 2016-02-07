//
//  messageDetailViewController.swift
//  Hjejni
//
//  Created by Muntazir on 01/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class messageDetailViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var rTableLabel: UILabel!
    @IBOutlet weak var rPidLabel: UILabel!
    @IBOutlet weak var sEmailLabel: UILabel!
    @IBOutlet weak var rEmailLabel: UILabel!
    @IBOutlet weak var rnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var sname: String?
    var message: String?
    var rname: String?
    var semail: String?
    var remail: String?
    var rtable: String?
    var rpid: String?
    var from: String?
    var pid: String?
    
    
    let type = NSUserDefaults().stringForKey("type")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("rpid:\(rpid)")
        print ("pid:\(pid)")
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.nameLabel.text = self.sname
            self.messageLabel.text = self.message
            self.rnameLabel.text = self.rname
            self.sEmailLabel.text = self.semail
            self.rEmailLabel.text = self.remail
            self.rTableLabel.text = self.rtable
            self.rPidLabel.text = self.rpid
            
            self.messageLabel.hidden = false
            self.nameLabel.hidden = false
            
            if (self.type == "Beneficial"){
                self.requestButton.hidden = true
            }
            
        })

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeButtonTapped(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("changeStatus") as! statusViewController
        viewController.table = rtable
        viewController.pid = rpid
        self.presentViewController(viewController, animated: true , completion: nil)
        
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("sendMessage") as! SendMessageViewController
        viewController.remail = semail
        viewController.rpid = rpid
        viewController.rtable = rtable
        viewController.rname = sname
        self.presentViewController(viewController, animated: true , completion: nil)
        
    }
    @IBAction func deleteButtonTapped(sender: AnyObject) {
        
        if(from == "rec" ){
            //Store Data to server
            let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/delete_rmessage.php");
            let request = NSMutableURLRequest(URL: myURL!);
            request.HTTPMethod = "POST";
    
            let postString = "pid=\(pid!)";
            print("string=\(postString)")
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
                                self.performSegueWithIdentifier("toMain", sender:self)
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
        else if (from == "sent"){
            
            //Store Data to server
            let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/delete_smessage.php");
            let request = NSMutableURLRequest(URL: myURL!);
            request.HTTPMethod = "POST";
            
            
            
            let postString = "pid=\(pid!)";
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
                                self.performSegueWithIdentifier("toSent", sender:self)
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

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
