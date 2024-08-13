//
//  LoginViewController.swift
//  Flash chart
//
//  Created by Chandra Kiran Reddy Yeduguri on 13/04/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            /*
             //Actual code given by firebase
             Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              // ...
            }*/
            
            //Code changed to our requirement
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // ...
                if let e = error {
                    print(e.localizedDescription)
                } else {
//                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "LoginToChart" {
////            let destinationVC = segue.destination as! ChartViewController
//            
//        }
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
