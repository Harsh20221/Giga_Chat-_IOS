//
//  ChatViewController.swift

import FirebaseAuth
import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBAction func Logoutbutton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true) //This will take us back to the root screen , do not forget to add this else the sign out will not work
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton=true;//This will hide the back button
        title="🦖GigaChat"
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

}
