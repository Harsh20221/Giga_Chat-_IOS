//
//  ChatViewController.swift

import FirebaseAuth
import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages :[Message] = [ ////? These are Dummy Messages that we'll display to check
    Message(sender: "123@gmai.com", body: "Hello This is a Test"),
    Message(sender: "456@gmail.com", body: "If you're seeing this then it's working "),
    Message(sender: "786", body: "I believe it is Working"),
    Message(sender: "91123", body: "Some final Checks and we'll be done ")
    ]
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
        tableView.dataSource=self ////!!!DO NOT FORGET TO ADD THIS STATEMENT OR ELSE YOUR TABLE VIEW WILL NOT LOAD THE TEXT THAT YOU HAVE SETUP AND YOU'LL BE LOST 
        
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

}
extension ChatViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //This is a part of necessary protocols responsible for creating the Controller
        return messages.count ///This will return the no of rows that we need to store our messages
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { ///This is also a necessary protocol for the chat controller
        let cell = tableView.dequeueReusableCell(withIdentifier:"ReusableCell" , for: indexPath)    ///Here you can return the        type of cell that you will need in your table view
        if #available(iOS 14.0, *) { ///Since textlabel is now depracted so we make an if else statement that will use the now latest .defaultcontent Configrator  if We have a supported IOS Device else it'll use the legacy textlabel instead
            var content = cell.defaultContentConfiguration()
            content.text = messages[indexPath.row].body
            cell.contentConfiguration = content
            return cell
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = messages[indexPath.row].body
            return cell ///Here indexpath.row will act as the row number for the messages , means it'll help the textlabel to display or to assign a rowno to each message that we created in the messages array at the above part of this code
        }
        
    }
    
    
}
