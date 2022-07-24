//
//  ViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 24/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerDayCount: UILabel!
    
    @IBOutlet weak var statsBarKnowledge: UILabel!
    @IBOutlet weak var statsBarSocial: UILabel!
    @IBOutlet weak var statsBarSickness: UILabel!
    @IBOutlet weak var statsBarStress: UILabel!
    
    @IBOutlet weak var progressBarDevelopment: UILabel!
    
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var actionTableView: UITableView!
    @IBOutlet weak var actionSelectedApp: UILabel!
    @IBOutlet weak var actionActButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func refreshScreenState(){
        progressBarDevelopment.text = ""
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}


