//
//  LoginViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/9/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    
<<<<<<< HEAD
    var mike = ""
=======
    var git: String?
>>>>>>> Elizabeth-Branch
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func userCanSignIn() -> Bool
    {
        if usernameTextField.text != "" && passwordTextField.text != ""
        {
            return true
        }
        return false
    }
    
    
    @IBAction func signInTapped(sender: UIButton)
//    signIn can be UIBarbutton Item if we want.
    {
        if userCanSignIn()
        {
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil
                {
                    print("login successful")
                    self.performSegueWithIdentifier("ShowMainViewSegue", sender: self)
                }
                else
                {
                    print(error?.localizedDescription)
                }
            }
        }
    }

}
