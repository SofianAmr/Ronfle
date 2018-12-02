//
//  RegisterViewController.swift
//  Ronfle
//
//  Created by Soso on 30/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var repeatpasswordRegister: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    
    @IBAction func register(_ sender: Any) {
        //print("register view")
        let username = usernameRegister.text!
        let password = passwordRegister.text!
        let repeatpassword = repeatpasswordRegister.text!
        
        //check if the fields are not empty
        if !(username.isEmpty || password.isEmpty || repeatpassword.isEmpty){
            //check if the password are equals
            if (password == repeatpassword) {
                
                // Insert User attributes in plist
                let concUsername = ("USERNAME("+username+")")
                global_InsertDb(key: concUsername, value: password)
                
                
                //Go to Sign in View - redirection
                let loginView:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(loginView, animated: true, completion: nil)
                
            }
            else{
                errorMessage.text = "Passwords are not equals"
                print("wrong passwords")
                return
            }
        } else {
            errorMessage.text = "Please enter values in fields"
            print("empty fields")
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSignUp.layer.cornerRadius = 5.0
        buttonSignUp.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
