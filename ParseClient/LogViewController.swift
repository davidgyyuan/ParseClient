//
//  LogViewController.swift
//  ParseClient
//
//  Created by David Yuan on 2/23/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit
import Parse
class LogViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBAction func SignUpTouch(_ sender: Any) {
        var user = PFUser()
        user.username = userText.text
        user.password = passText.text
        user.email = userText.text
        user.signUpInBackground { (succeeded:Bool, error:Error?) in
            if let error = error{
                let alertController = UIAlertController(title: "Sign-Up Error", message: error.localizedDescription, preferredStyle: .alert)
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                
            }
            
        }
      
    }
  
    @IBAction func LogInTouch(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userText.text!, password: passText.text!){(user: PFUser?, error: Error?) -> Void in
            if user != nil {
               self.performSegue(withIdentifier: "push", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Sign-In Error", message: error?.localizedDescription, preferredStyle: .alert)
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
