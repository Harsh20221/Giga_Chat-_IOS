//
//  ChatViewController.swift

import FirebaseAuth
import UIKit
import FirebaseFirestoreInternal

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore() ///This will Initialize the database to be used below when the user will press send button
    var messages :[Message] = [ ////? These are Dummy Messages that we'll display to check
        
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
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
        
    }
    
    func loadMessages(){
        
        db.collection("messages").order(by: "dateField").addSnapshotListener{ (QuerySnapshot, error) in ////??db.collection method will help us to get retrieve the messages
            ///This .order(by:"dateField") will order all the messages by dateField
            ///
            ///??This .addsnapshotListener along with db.collection will help us to reflect instant changes in our tableview , This snapshot listener will reload the screen whenever we have a new message
            
            self.messages = [] ///!!Reinitialise this message array to be an empty Array so that we don't have duplicate messages , we load a frezh messages array to avoid duplicates
            if  let e=error {  ///??This if let is used for better error handling to display the error if there is one or else display the required result
                print("There is an issue Retrieveing data from Firestore ")
            }
            else {
                if let snapshotDocuments = QuerySnapshot?.documents{ //??This QuerySnapshot.documents stores all the data stored in our database and in order to read all this data we use the for loop below and we print doc . data in the console currently to check if the data is retrieved successfully
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data["senderField"]as?String,let  messageBody=data["bodyField"] as?String {// If message is available then store them in a messageSender Variable and body in messageBody and append the message in messages Array,
                            let newMessage = Message(sender: messageSender, body: messageBody)//Store the new message in a newmesasage Variable with fields sender and body
                            self.messages.append(newMessage) ///Append the messages
                            DispatchQueue.main.async{ //This Dispatch queue will process the following operation in the background
                                self.tableView.reloadData() //We'll reload tableview after we have retrieved the messages
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if  let messageBody=messageTextfield.text,  ///This will check if the message body has a meassage text an a sender email then it'll forward the message to the Database
            let messageSender=Auth.auth().currentUser?.email{
            db.collection("messages").addDocument(data:[ "senderField":messageSender,"bodyField":messageBody,"dateField":Date().timeIntervalSince1970],completion: {(error) in ////THEdateField will add a timestamp or we can say a time with every message stored or sent
                if let e = error {
                    print("There is an issue retrieving data From The Firebase Database ")
                }
                else {
                    print("Successively Saved Data ")
                }})
        }
        messageTextfield.text="" ////This will empty the text Box once the message is sent  }
        
        
    }}
    extension ChatViewController :UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //This is a part of necessary protocols responsible for creating the Controller
            return messages.count ///This will return the no of rows that we need to store our messages
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { ///This is also a necessary protocol for the chat controller
            let message=messages[indexPath.row] //!!VIMP to store messages index path method in a variable because we'll use it in 2 places in this function
            ///Here indexpath.row will act as the row number for the messages , means it'll help the textlabel to display or to assign a rowno to each message that we created in the messages array at the above part of this code
           
            let cell = tableView.dequeueReusableCell(withIdentifier:"ReusableCell" , for: indexPath) as! MessageCell   ///Here you can return the        type of cell that you will need in your table view
            
            cell.label.text = message.body
            if message.sender==Auth.auth().currentUser?.email{
                cell.leftImageView.isHidden=true
                cell.rightImageView.isHidden=false
                cell.messageBubble.backgroundColor=UIColor(named: "BrandLightPurple")
                cell.label.textColor=UIColor(named: "BrandPurple")
            }
            else {
                cell.leftImageView.isHidden=false
                cell.rightImageView.isHidden=true
                cell.messageBubble.backgroundColor=UIColor(named: "BrandPurple")
                cell.label.textColor=UIColor(named: "BrandLightPurple")
            }
            
            return cell
        }
        
        
    }

