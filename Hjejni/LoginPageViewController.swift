//
//  LoginPageViewController.swift
//  Hjejni
//
//  Created by Muntazir on 27/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Login"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
       
        let email = inputEmail.text;
        let password = inputPassword.text;
        
        
        
        if(email!.isEmpty || password!.isEmpty)
        {
            displayMyAlertMessage("All fields are required!");
            return;
        }
        
        
        //Send User Data to server
        let myURL = NSURL(string: "http://52.89.129.22/android_login_api/login_ios.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(email!)&password=\(password!)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        //Execute Task
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
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


                let resultValue = json["error"] as? Bool
                print("result:\(resultValue!)")
        
                
                if(resultValue! == false){
                    //Login is successfull
                    
                    let getName = json["name"] as! String
                    let getEmail = json["email"] as! String
                    let getType = json["type"] as! String
                    
                    print("name:\(getName)")
                    print("email:\(getEmail)")
                    print("type:\(getType)")
                    
                    NSUserDefaults().setObject(getName, forKey: "name")
                    NSUserDefaults().setObject(getEmail, forKey: "email")
                    NSUserDefaults().setObject(getType, forKey: "type")
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                    //NSUserDefaults().setObject(result!, forKey: "name")
                    NSUserDefaults.standardUserDefaults().synchronize();
                    dispatch_async(dispatch_get_main_queue(), {
                        //Code that presents or dismisses a view controller here
                        self.performSegueWithIdentifier("welcomeView", sender:self )
                        });
                    
                    
                }
                
                if(resultValue! == true){
                    json["error_msg"] as! String!
                }
                dispatch_async(dispatch_get_main_queue(), {
                    //Display Alert Message With Confirmation
                    let myAlert = UIAlertController(title: "Message", message: json["error_msg"] as! String!, preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { action in
                    }
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated:true, completion:nil);
                });

                
                
            }
            catch let error as NSError {
                print(error)
            }

            
        }
        task.resume()
    }

    func displayMyAlertMessage (userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
    
    
}


    
