//
//  AfterLoginViewController.swift
//  firebaseTest
//
//  Created by 張智涵 on 2016/6/29.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit

class AfterLoginViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBAction func didLogoutButton(sender: AnyObject) {
        // logout firebase app
        try! FIRAuth.auth()!.signOut()
        // set FBtoken to nil
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("HomeView")
        self.presentViewController(viewController, animated: true, completion: nil)


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width/2
        self.userProfileImageView.clipsToBounds = true
        
        // Because right now only FB account has profile pic and username. Check FBSDKtoken then
        if FBSDKAccessToken.currentAccessToken() != nil {
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid
            
            self.userNameLabel.text = name
            let data = NSData(contentsOfURL: photoUrl!)
            self.userProfileImageView.image = UIImage(data: data!)
            
            
            
            
        } else {
            // No user is signed in.
        }
        } else {
            //not Facebook user, so no profile pic
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func shareButton(sender: AnyObject) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            
            var activityItems: [AnyObject]?
            activityItems = ["I am starting to use this app! Join me!"]
            
        let activityController = UIActivityViewController(activityItems:
            activityItems!, applicationActivities: nil)
        self.presentViewController(activityController, animated: true,
                                   completion: nil)
        }
    }


}
