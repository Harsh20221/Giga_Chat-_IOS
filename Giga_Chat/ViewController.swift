//
//  WelcomeViewController.swift

//

import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) //Make sure to add this super method to ensure it executes safely 
        navigationController?.isNavigationBarHidden=true //Hide Navigation bar when loading into the App
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden=false //Make Navigation Bar Reappear after finally lOADING Up
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text="🦖GigaChat";
      
    }
    

}
