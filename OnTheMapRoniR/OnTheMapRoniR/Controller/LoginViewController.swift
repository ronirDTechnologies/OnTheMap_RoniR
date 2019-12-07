//
//  LoginViewController.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/5/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtBx: UITextField!
    
    @IBOutlet weak var passwordTxtBx: UITextField!
    
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func loginToUdacity(_ sender: Any)
    {
       getSessionHelper()
    }
    
    // Lets user create a Udacity user name
    @IBAction func launchUdacitySignUp(_ sender: Any)
    {
        print("LAUNCH UDACITY SIGNUP")
        UIApplication.shared.open(OnTheMapClient.Endpoints.getUdacitySignUpPage.url , options: [:], completionHandler: nil)
    }
    
    func getUserFullNameHelperResponse(success:Bool, error: Error?)
    {
        print("FIRST NAME: \(OnTheMapClient.Auth.firstName) LAST NAME: \(OnTheMapClient.Auth.lastName)")
    }
    
    func getUserFullName () -> Void
    {
        OnTheMapClient.getUserInfo(userKey: OnTheMapClient.Auth.userKey, completion: self.getUserFullNameHelperResponse(success:error:))
    }
    
    func getSessionHelper() -> Void
    {
        OnTheMapClient.getSessionId(userName: self.emailTxtBx.text ?? "", password: self.passwordTxtBx.text ?? "", completion: self.handleSessionResponse(success:error:))
        
    }
    
    func handleSessionResponse(success: Bool, error: Error?)
    {
        // If successfully obtained a session , then move to next screen
        if success
        {
            getUserFullName()
            self.performSegue(withIdentifier: "AfterLoginSuccessSegue", sender: nil)
            print("OBTAINED SESSION ID : NOW LOGGIN IN")
        }
        else
        {
            showLoginFailure(message: error?.localizedDescription ?? "")
            
            print("FAILED TO OBTAIN SESSION")
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}

