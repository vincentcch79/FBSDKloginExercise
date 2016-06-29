//
//  ViewController.swift
//  firebaseTest
//
//  Created by 張智涵 on 2016/6/15.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var Username: UITextField!
    
    
    @IBOutlet weak var Password: UITextField!
    

    
    
    @IBOutlet weak var loginButtonFb: FBSDKLoginButton!
    
  
    let signInButton: GIDSignInButton = GIDSignInButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.loginButtonFb.hidden = true
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let afterLoginViewController: UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("AfterLoginView")
                self.presentViewController(afterLoginViewController, animated: true, completion: nil)
                
                
                
            } else {
                // No user is signed in.
                self.loginButtonFb.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButtonFb.delegate = self
                self.loginButtonFb.hidden = false

            }
        }
        

   

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func CreateAccount(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(Username.text!, password: Password.text!, completion: { (user:FIRUser?, error:NSError?) in
            if let error = error {
                print("Creating the user failed! \(error)")
                return
            }
            
            if let user = user {
                print("user : \(user.email) has been created successfully.")
            }
        })
    
        
 }
    
    @IBAction func userLogin(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!, completion: { (user:FIRUser?, error:NSError?) in
            if let error = error {
                print("login failed! \(error)")
                return
            }
            
            if let user = user {
                print("user : \(user.email) has been signed in successfully.")
            }
        })
        
    }
    
}
extension ViewController: FBSDKLoginButtonDelegate {

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        
        FIRAuth.auth()?.signInWithCredential(credential, completion: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("firebase sign out error: \(error)")
        }

    }
}
    
    





//        FIRAuth.auth()?.createUserWithEmail(Username.text!, password: Password.text!, completion: {
//             user, error in
//            if error != nil {
//                self.login()
//            } else {
//                print("User created")
//                self.login()
//            }
//        })
//    }
//
//    func login(){
//        FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!, completion: {
//
//             user, error in
//
//            if error != nil{
//                print("Incorrect!")
//            } else {
//                print("Heeeey!")
//            }
//        })
//    }

