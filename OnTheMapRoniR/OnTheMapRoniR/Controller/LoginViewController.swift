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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginToUdacity(_ sender: Any) {
        getSessionHelper()
    }
    @IBAction func launchUdacitySignUp(_ sender: Any) {
        print("LAUNCH UDACITY SIGNUP")
        UIApplication.shared.open(OnTheMapClient.Endpoints.getUdacitySignUpPage.url , options: [:], completionHandler: nil)
    }
    
    func getSessionHelper() -> Void{
        OnTheMapClient.getSessionId(userName: self.emailTxtBx.text ?? "", password: self.passwordTxtBx.text ?? "", completion: self.handleSessionResponse(success:error:))
    }
    
    func handleSessionResponse(success: Bool, error: Error?){
        if success {
            print("OBTAINED SESSION ID : NOW LOGGIN IN")
        }
        else{
            print("FAILED TO OBTAIN SESSION")
        }
    }
    
}

