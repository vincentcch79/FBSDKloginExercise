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

}
