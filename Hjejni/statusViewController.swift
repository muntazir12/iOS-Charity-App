//
//  statusViewController.swift
//  Hjejni
//
//  Created by Muntazir on 02/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class statusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var inputStatus: UITextField!
    
    @IBOutlet weak var statusPicker: UIPickerView!
    
     var statusData: [String] = [String]()
    
    var table: String?
    var pid: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        statusData = ["Select Status","Not Handled", "Handled (Completed)"]

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return statusData.count
       
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusData[row]
       
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
            inputStatus.text = "\(statusData[row])"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeButtonTapped(sender: AnyObject) {
        
        let status = inputStatus.text
        
        //Check Empty Field
        if (status! == "Select Status" || status!.isEmpty)
        {
            displayMyAlertMessage("Please Select Appropriate Status");
            return;
        }
        
        if(table == "Haj" ){
            //Store Data to server
            let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/update_haj.php");
            let request = NSMutableURLRequest(URL: myURL!);
            request.HTTPMethod = "POST";
        
            let postString = "status=\(status!)&pid=\(pid!)";
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
    else if (table == "Umrah"){
    
            //Store Data to server
            let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/update_umrah.php");
            let request = NSMutableURLRequest(URL: myURL!);
            request.HTTPMethod = "POST";
            
            
            
            let postString = "status=\(status!)&pid=\(pid!)";
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

    
    }
    
    func displayMyAlertMessage (userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated:true, completion:nil);
        
        
        
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
