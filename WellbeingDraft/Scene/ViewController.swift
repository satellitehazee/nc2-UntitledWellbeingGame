//
//  ViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 24/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerTimeIndicator: UILabel!
    
    @IBOutlet weak var statsBarKnowledge: UILabel!
    @IBOutlet weak var statsBarSocial: UILabel!
    @IBOutlet weak var statsBarSickness: UILabel!
    @IBOutlet weak var statsBarStress: UILabel!
    
    @IBOutlet weak var progressBarDevelopment: UILabel!
    
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var actionTableView: UITableView!
    @IBOutlet weak var actionSelectedApp: UILabel!
    @IBOutlet weak var actionActButton: UIButton!
    
    var player: Player = Player(currentDay: 1, currentTimeframe: 0, progressDevelopment: 20, statsKnowledge: 30, statsSocial: 30, statsSickness: 30, statsStress: 30)
    var action: [Action] = [
        Action(actionName: "Xcode", progressChangeDevelopment: 15, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 15, availability: "1111"),
        Action(actionName: "Sketch", progressChangeDevelopment: 15, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 15, availability: "1111"),
        Action(actionName: "Notion", progressChangeDevelopment: 5, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Miro", progressChangeDevelopment: 5, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Zoom", progressChangeDevelopment: 5, statsChangeKnowledge: 15, statsChangeSocial: 10, statsChangeSickness: 15, statsChangeStress: 15, availability: "1000"),
        Action(actionName: "Safari", progressChangeDevelopment: 0, statsChangeKnowledge: 10, statsChangeSocial: -10, statsChangeSickness: 10, statsChangeStress: 0, availability: "1111"),
        Action(actionName: "Youtube", progressChangeDevelopment: 0, statsChangeKnowledge: 5, statsChangeSocial: -5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Discord", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 5, statsChangeStress: -5, availability: "0111"),
        Action(actionName: "Sleep", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: -30, statsChangeStress: -30, availability: "0001"),
        Action(actionName: "Netflix", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: 0, statsChangeStress: -15, availability: "1111"),
        Action(actionName: "Game", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: 0, statsChangeStress: -15, availability: "1111"),
        Action(actionName: "Nap", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: -10, statsChangeStress: -10, availability: "1110")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func refreshScreenState(){
        
    }
    
    func updateBar(){
        progressBarDevelopment.text = ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}


