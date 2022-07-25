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
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var actionTableView: UITableView!
    @IBOutlet weak var actionSelectedApp: UILabel!
    @IBOutlet weak var actionActButton: UIButton!
    
    let statsList = ["Knowledge", "Social", "Sickness", "Stress"]
    
    var player: Player = Player(currentDay: 1, currentTimeframe: 0, progressDevelopment: 20, statsKnowledge: 30, statsSocial: 30, statsSickness: 30, statsStress: 30, statsUpperLimit: 100, statsBottomLimit: 0)
    var action: [Action] = [
        Action(actionName: "Xcode", progressChangeDevelopment: 10, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 25, availability: "1111"),
        Action(actionName: "Sketch", progressChangeDevelopment: 10, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 25, availability: "1111"),
        Action(actionName: "Notion", progressChangeDevelopment: 2, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Miro", progressChangeDevelopment: 2, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Zoom", progressChangeDevelopment: 2, statsChangeKnowledge: 15, statsChangeSocial: 10, statsChangeSickness: 15, statsChangeStress: 25, availability: "1000"),
        Action(actionName: "Safari", progressChangeDevelopment: 0, statsChangeKnowledge: 10, statsChangeSocial: -10, statsChangeSickness: 10, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Youtube", progressChangeDevelopment: 0, statsChangeKnowledge: 5, statsChangeSocial: -5, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Discord", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 5, statsChangeStress: -5, availability: "0111"),
        Action(actionName: "Instagram", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 5, statsChangeStress: 5, availability: "1111"),
        Action(actionName: "Netflix", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: 0, statsChangeStress: -15, availability: "1111"),
        Action(actionName: "Game", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 5, statsChangeSickness: 0, statsChangeStress: -15, availability: "1111"),
        Action(actionName: "Sleep", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -5, statsChangeSickness: -30, statsChangeStress: -30, availability: "0001"),
        Action(actionName: "Nap", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -5, statsChangeSickness: -10, statsChangeStress: -10, availability: "1110")
    ]
    var selectedApp: Int = -1
    var availableAppList: [Action] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshScreenState()
        actionTableView.delegate = self
        actionTableView.dataSource = self
        logTextView.text = "Untitled Wellbeing Game.\n"
        // Do any additional setup after loading the view.
    }
    
    func refreshScreenState(){
        checkAvailableApp()
        resetAction()
        updateBar()
        updateNotes()
        actionTableView.reloadData()
    }
    
    @IBAction func doAction(_ sender: Any) {
        if selectedApp != -1 {
            player.progressDevelopment += (availableAppList[selectedApp].progressChangeDevelopment + (player.statsKnowledge/20))
            player.statsKnowledge += availableAppList[selectedApp].statsChangeKnowledge
            player.statsSocial += availableAppList[selectedApp].statsChangeSocial
            player.statsSickness += availableAppList[selectedApp].statsChangeSickness
            player.statsStress += availableAppList[selectedApp].statsChangeStress
            
            limitStatChanges()
            
            player.currentTimeframe += 1
            if player.currentTimeframe == 4 {
                player.currentTimeframe = 0
                player.currentDay += 1
            }
            
            appendLog()
        }
        refreshScreenState()
    }
    
    func checkState(){
        if player.currentDay == 7 {
            
        }
    }
    
    func updateNotes(){
        
        var notesText = ""
        
        if player.currentDay == 1 {
            notesText.append("It's your last sprint!\n")
            notesText.append("Fill out the development bar by the end of day 7.\n")
            notesText.append("..and make sure to manage your stats wisely.\n\n")
        }
        if player.currentDay == 4 {
            notesText.append("3 days left until deadline..\n")
        }
        if player.currentDay == 7 {
            notesText.append("Almost there! Make sure to finish your development!\n")
        }
        if player.progressDevelopment == 100 {
            notesText.append("Development has been finished! Congratulations!\n")
        }
        if player.statsSocial < 15 {
            notesText.append("Social is too low! Don't be anti-social.\n")
        }
        if player.statsSickness > 80 {
            notesText.append("Sickness is too high! Have a proper rest.\n")
        }
        if player.statsStress > 80 {
            notesText.append("Stress is too high! Touch grass.\n")
        }
            
        
        notesTextView.text = notesText
    }
    
    func appendLog(){
        logTextView.text.append("\nDone \(availableAppList[selectedApp].actionName).")
        if availableAppList[selectedApp].progressChangeDevelopment != 0 {
            logTextView.text.append(" Development increased by \((availableAppList[selectedApp].progressChangeDevelopment + ( player.statsKnowledge/20)))")
        }
        
        let changes = [availableAppList[selectedApp].statsChangeKnowledge, availableAppList[selectedApp].statsChangeSocial, availableAppList[selectedApp].statsChangeSickness, availableAppList[selectedApp].statsChangeStress]
        
        for i in 0...3{
            if changes[i] != 0 {
                if changes[i] > 0 {
                    logTextView.text.append("\n\(statsList[i]) increased by \(changes[i]).")
                } else {
                    logTextView.text.append("\n\(statsList[i]) decreased by \(changes[i] * -1).")
                }
                
            } else {
                logTextView.text.append("\nNo changes to \(statsList[i]).")
            }
        }
        logTextView.scrollRangeToVisible(NSMakeRange(logTextView.text.count - 1, 1))
    }
    
    func limitStatChanges(){
        player.progressDevelopment = min(player.statsUpperLimit, player.progressDevelopment)
        player.statsKnowledge = min(player.statsUpperLimit, player.statsKnowledge)
        player.statsSocial = min(player.statsUpperLimit, player.statsSocial)
        player.statsSickness = min(player.statsUpperLimit, player.statsSickness)
        player.statsStress = min(player.statsUpperLimit, player.statsStress)
        
        player.progressDevelopment = max(player.statsBottomLimit, player.progressDevelopment)
        player.statsKnowledge = max(player.statsBottomLimit, player.statsKnowledge)
        player.statsSocial = max(player.statsBottomLimit, player.statsSocial)
        player.statsSickness = max(player.statsBottomLimit, player.statsSickness)
        player.statsStress = max(player.statsBottomLimit, player.statsStress)
    }
    
    func resetAction(){
        selectedApp = -1
        actionSelectedApp.text = "-"
        
    }
    
    func updateBar(){
        progressBarDevelopment.text = barIntToText(progress: player.progressDevelopment)
        statsBarKnowledge.text = barIntToText(progress: player.statsKnowledge)
        statsBarSocial.text = barIntToText(progress: player.statsSocial)
        statsBarSickness.text = barIntToText(progress: player.statsSickness)
        statsBarStress.text = barIntToText(progress: player.statsStress)
        headerTimeIndicator.text = "Day \(player.currentDay) - \(timeframeIntToText(timeframe: player.currentTimeframe))"
    }
    
    func updateBarNumber(){
        progressBarDevelopment.text = "\(player.progressDevelopment) / \(player.statsUpperLimit)"
        statsBarKnowledge.text = "\(player.statsKnowledge) / \(player.statsUpperLimit)"
        statsBarSocial.text = "\(player.statsSocial) / \(player.statsUpperLimit)"
        statsBarSickness.text = "\(player.statsSickness) / \(player.statsUpperLimit)"
        statsBarStress.text = "\(player.statsStress) / \(player.statsUpperLimit)"
        headerTimeIndicator.text = "Day \(player.currentDay) - \(timeframeIntToText(timeframe: player.currentTimeframe))"
    }
    
    func checkAvailableApp(){
        availableAppList.removeAll()
        for act in action {
            var idx = 0
            for ch in act.availability {
                if idx == player.currentTimeframe && ch == "1" {
                    availableAppList.append(act)
                }
                idx += 1
            }
        }
    }
    
    func barIntToText(progress: Int) -> String{
        var progressText = ""
        let progressConvert = max(0, progress/5)
        for _ in 0...progressConvert {
            progressText.append("#")
        }
        return progressText
    }
    
    func timeframeIntToText(timeframe: Int) -> String{
        let timeframeText = ["Morning 🌄", "Noon ☀️", "Dusk 🌇", "Night 🌙"]
        return timeframeText[timeframe]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableAppList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = actionTableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath)
        cell.textLabel?.text = availableAppList[indexPath.row].actionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedApp = indexPath.row
        actionSelectedApp.text = availableAppList[selectedApp].actionName
    }
    


}


