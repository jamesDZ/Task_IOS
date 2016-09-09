//
//  ViewController.swift
//  Task_IOS
//
//  Created by ALOK KUMAR on 09/09/16.
//  Copyright © 2016 ALOK KUMAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate{

    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var btnFB: FBSDKLoginButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var username2: UILabel!
    @IBOutlet weak var email: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        facebookPage()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large), email,age,timezone"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let stremail: String = (result.objectForKey("email") as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            self.username.text = " \(strFirstName) "
            self.username2.text = "\(strLastName)"
            self.email.text = "\(stremail)"
            self.profileimage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }

    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        profileimage.image = nil
        username.text = ""
    }

    func facebookPage()
    {
        btnFB.readPermissions = ["public_profile", "email", "user_friends"];
        btnFB.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

