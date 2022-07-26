//
//  MainMenuViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 26/07/22.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var collectionButton: UIButton!
    
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "gotoGameSegue", sender: self)
    }
    @IBAction func collection(_ sender: Any) {
        performSegue(withIdentifier: "gotoCollectionSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
