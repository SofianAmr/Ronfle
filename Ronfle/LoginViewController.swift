//
//  LoginViewController.swift
//  Ronfle
//
//  Created by Soso on 27/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    
    @IBAction func login(_ sender: Any) {
        print("submit cklicked")
        let usernameLogin = username.text!
        let passwordLogin = password.text!
        
        //check if the fields are not empty
        if !(usernameLogin.isEmpty || passwordLogin.isEmpty) {
            //get local 'db' paths
            let path = Bundle.main.path(forResource: "database", ofType: "plist")
            let url = URL(fileURLWithPath: path!)
            //print(url.absoluteString)
            
            //check if the user already exist in database
            let obj = NSDictionary(contentsOf: url)
            let concUsername = ("USERNAME("+username.text!+")")
            if let str = obj!.value(forKey: concUsername) {
                print("Found password :",str)
                guard let pass = str as? String else {return}
                //check if the password is wrong or not
                
                if  (pass == password.text!){
                    
                    //User is loggedin
                    print("Succefully logged in!")
                    
                    //Add a 'Cookie' in plist
                    global_InsertDb(key: "SESSION_ACTIVE", value: usernameLogin)
                    
                    //Go to the account view - redirection
                    let profileView:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    self.present(profileView, animated: true, completion: nil)
                    
                    
                } else {
                    print("wrong password or username")
                    errorMessage.text = "Wrong password or username"
                }
            } else {
                errorMessage.text = "Wrong password or username"
                print("Couldn't find username in database")
            }
        } else {
            errorMessage.text = "Please enter values in fields"
            print("empty fields")
            return
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLogin.layer.cornerRadius = 5.0
        buttonLogin.layer.masksToBounds = true
        
        buttonRegister.layer.cornerRadius = 5.0
        buttonRegister.layer.masksToBounds = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

