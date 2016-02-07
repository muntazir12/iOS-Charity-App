import UIKit

class RegisterPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var pickerItem: UITextField!
    @IBOutlet weak var inputType: UIPickerView!
    
    var pickerData: [String] = [String]()


    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Register"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Connect data:
        self.inputType.delegate = self
        self.inputType.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Select Type","Beneficial", "Donor"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerItem.text = "\(pickerData[row])"
        
    }

    
    
    
    @IBAction func RegisterButtonTapped(sender: AnyObject) {
    
    
        let name = inputName.text;
        let email = inputEmail.text;
        let password = inputPassword.text;
        let type = pickerItem.text;
        
        //Check Empty Fields
        if(name!.isEmpty || email!.isEmpty || password!.isEmpty || type!.isEmpty || type! == "Select Type")
        {
            //Display Alert Message
            
            displayMyAlertMessage("All fields are required!");
            return;
          
        }
        
        if ( password!.characters.count <= 5 )
        {
            print("pwd=\(password?.characters.count)")
            displayMyAlertMessage("At least 6 character Password is required!");
            return;
        }
        
       // NSUserDefaults().setObject(name!, forKey: "name")
       // NSUserDefaults().setObject(type!, forKey: "type")
       // NSUserDefaults().setObject(email!, forKey: "email")
        
        //Store Data to server 
        let myURL = NSURL(string: "http://52.89.129.22/android_login_api/register.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(email!)&name=\(name!)&password=\(password!)&type=\(type!)";
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
                
            
            let resultValue = json["error"] as? Bool
                print("result:\(resultValue)")
                
                var isUserRegistered:Bool = false;
                if(resultValue == true) { isUserRegistered=false; }
                var messageToDisplay:String = json["error_msg"] as! String!;
                if(isUserRegistered)
                {
                    messageToDisplay = json["error_msg"] as! String!;
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                //Display Alert Message With Confirmation
                    let myAlert = UIAlertController(title: "Message", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { action in
            
                    }
                    let loginAction = UIAlertAction(title: "Login", style: UIAlertActionStyle.Default){
                        action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    myAlert.addAction(okAction);
                    myAlert.addAction(loginAction);
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
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    
    
}