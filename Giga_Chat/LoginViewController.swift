//
//  LoginViewController.swift


import UIKit
import FirebaseAuth
import FirebaseCore
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
       
        if let emailtext=emailTextfield.text , let password=passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: emailtext, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let e = error {
                    print (e.localizedDescription)
                    print("error has occured")
                }
                
                else {
                    self?.performSegue(withIdentifier: "FinalResult", sender: self)
                }
                
              
            }
            
            
        }
        
        
        
    }
    
}
