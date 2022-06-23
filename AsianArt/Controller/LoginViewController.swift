//
//  LoginViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 5/13/21.
//

import UIKit
import ParseSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testParseConnection()
    }
    
    func testParseConnection() {
//        let savedArt = PFObject(className: "SavedArt")
//        savedArt["title"] = "hey"
//        savedArt.saveInBackground { (success, error) in
//            if (success) {
//                print("You connected")
//            } else {
//                print("its okay try again")
//            }
//        }
    }
    
    
    @IBAction func onSignInButton(_ sender: Any) {
//        let username = usernameField.text!
//        let password = passwordField.text!
        
//        PFUser.logInWithUsername(inBackground: username, password: password) {
//            (user: PFUser?, error: Error?) -> Void in
//            if user != nil {
//                self.performSegue(withIdentifier: "loginToHome", sender: self)
//            } else {
//                print("Error: \(String(describing: error?.localizedDescription)). It's ok try again.")
//            }
//        }
    }
    
    @IBAction func onSignUpButton(_ sender: Any) {
//        let user = PFUser()
//        user.username = usernameField.text!
//        user.password = passwordField.text!
        
//        user.signUpInBackground { (succeeded: Bool, error: Error?) -> Void in
//            if let error = error {
//                _ = error.localizedDescription
//                print("You got this error: \(error.localizedDescription). It's okay try again")
//            } else {
//                self.performSegue(withIdentifier: "loginToHome", sender: self)
//                print("Sign Up successful")
//            }
//        }
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
