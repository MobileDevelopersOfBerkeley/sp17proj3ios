//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Amy on 2/21/17.
//  Copyright © 2017 Amy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {
    
    var appTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
       
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "turquoise_background")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTitle() {
        appTitle = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.3 * UIScreen.main.bounds.height))
        appTitle.font = UIFont.italicSystemFont(ofSize: 34)
        appTitle.adjustsFontSizeToFitWidth = false
        appTitle.textAlignment = .center
        appTitle.text = "MDB Socials"
        appTitle.textColor = UIColor.lightGray
        view.addSubview(appTitle)
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.4 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 30))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email"
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        self.view.addSubview(emailTextField)
        
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.4 * UIScreen.main.bounds.height + 40, width: UIScreen.main.bounds.width - 20, height: 30))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        
        loginButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        self.view.addSubview(loginButton)
        print("2")
        signupButton = UIButton(frame: CGRect(x: 0.5 * UIScreen.main.bounds.width + 10, y: 0.8 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 3.0
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
    }
    
    func loginButtonClicked(sender: UIButton!) {
        // performs login
        let email = emailTextField.text!
        let password = passwordTextField.text!
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            }
            
        })
    }
    
    
    func signupButtonClicked(sender: UIButton!) {
        performSegue(withIdentifier: "toSignup", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


