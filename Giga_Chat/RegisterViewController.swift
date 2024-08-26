//
//  RegisterViewController.swift

//

import UIKit
import FirebaseAuth
/////
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email=emailTextfield.text , let password=passwordTextfield.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print (e.localizedDescription)
                    print("error has occured")
                }
                else {  ///Do not use self.should perform segueway else it will not transition to different screen 
                    self.performSegue(withIdentifier:  "FinalResult", sender: self) //Do not forget to add self before calling any method in the class ///Passwords must be atleast 6 charecters long
                   
                }
            }
        }
    }
    
}
