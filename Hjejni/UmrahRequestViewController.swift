//
//  UmrahRequestViewController.swift
//  Hjejni
//
//  Created by Muntazir on 28/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class UmrahRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var inputDate: UITextField!
    
    @IBOutlet weak var inputDependent: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputCountry: UITextField!
    @IBOutlet weak var inputStatus: UITextField!
    @IBOutlet weak var inputGender: UITextField!

    
    
    
    @IBOutlet weak var CountryPicker: UIPickerView!
    @IBOutlet weak var StatusPicker: UIPickerView!
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    
    var GenderData: [String] = [String]()
    var StatusData: [String] = [String]()
    var CountryData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.GenderPicker.delegate = self
        self.GenderPicker.dataSource = self
        self.StatusPicker.delegate = self
        self.StatusPicker.dataSource = self
        self.CountryPicker.delegate = self
        self.CountryPicker.dataSource = self
      
        
        
        
        // Input data into the Array:
        GenderData = ["Select Gender","Male", "Female"]
        StatusData = ["Select Status","Single", "Family"]
        CountryData = ["Select Country","Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]
        
        //Getting Data From NSUserDefault
        let userName = NSUserDefaults().stringForKey("name")
        let userEmail = NSUserDefaults().stringForKey("email")
        
        inputEmail.text = userEmail;
        inputName.text = userName;
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return GenderData.count
        }else if (pickerView.tag == 2){
            return StatusData.count
        }else if (pickerView.tag == 3){
            return CountryData.count
        }
        return CountryData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return GenderData[row]
        }else if (pickerView.tag == 2) {
            return StatusData[row]
        }else if (pickerView.tag == 3) {
            return CountryData[row]
        }
        else{
            return "\(CountryData[row])"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag == 1){
        inputGender.text = "\(GenderData[row])"
        }else if(pickerView.tag == 2){
        inputStatus.text = "\(StatusData[row])"
        }else if(pickerView.tag == 3){
        inputCountry.text = "\(CountryData[row])"
        }else{
        }
        
        let family = inputStatus.text;
        if(family == "Family"){
            inputDependent.hidden = false;
        }else{
            inputDependent.hidden = true;
        }
        
    }
    
    @IBAction func DateFieldEdit(sender: UITextField) {
        
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        datePickerValueChanged(datePickerView) // Set the date on start.
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        inputDate.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func doneButton(sender:UIButton)
    {
        inputDate.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    
    @IBAction func SubmitButtonTapped(sender: AnyObject) {
        
        let family = inputStatus.text;
        let name = inputName.text;
        let email = inputEmail.text;
        let gender = inputGender.text;
        let country = inputCountry.text;
        let age = inputDate.text;
        let dependent = inputDependent.text;
        
        //Check Empty Fields
        if(gender!.isEmpty || gender == "Select Gender" || family!.isEmpty || family == "Select Status" || age!.isEmpty || country!.isEmpty || country! == "Select Country")
        {
            //Display Alert Message
            
            displayMyAlertMessage("All fields are required!");
            return;
            
        }
        
        
        
        //Store Data to server
        let myURL = NSURL(string: "http://52.89.129.22/android_login_api/api/create_umrah.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.HTTPMethod = "POST";
        
        
        
        let postString = "email=\(email!)&name=\(name!)&age=\(age!)&gender=\(gender!)&family=\(family!)&country=\(country!)&dependent=\(dependent!)";
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
                            self.performSegueWithIdentifier("toMain", sender: self)
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

    
}
