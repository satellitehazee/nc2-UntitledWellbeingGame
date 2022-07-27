//
//  ViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 24/07/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    


    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var developmentView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var desktopImageView: UIImageView!
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerTimeIndicator: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var knowledgeProgressView: UIProgressView!
    @IBOutlet weak var socialProgressView: UIProgressView!
    @IBOutlet weak var sicknessProgressView: UIProgressView!
    @IBOutlet weak var stressProgressView: UIProgressView!
    
    @IBOutlet weak var developmentProgressView: UIProgressView!
    
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var actionCollectionView: UICollectionView!
    @IBOutlet weak var actionSelectedAppLabel: UILabel!
    @IBOutlet weak var actionActButton: UIButton!
    
    @IBOutlet weak var actionDevelopmentChangeLabel: UILabel!
    @IBOutlet weak var actionKnowledgeChangeLabel: UILabel!
    @IBOutlet weak var actionSocialChangeLabel: UILabel!
    @IBOutlet weak var actionSicknessChangeLabel: UILabel!
    @IBOutlet weak var actionStressChangeLabel: UILabel!

    
    let statsList = ["Knowledge", "Social", "Sickness", "Stress"]
    
    var player: Player = Player(currentDay: 1, currentTimeframe: 0, progressDevelopment: 2, statsKnowledge: 20, statsSocial: 50, statsSickness: 30, statsStress: 25, statsUpperLimit: 100, statsBottomLimit: 0)
    var action: [Action] = [
        Action(actionName: "Xcode", progressChangeDevelopment: 10, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 25, isPickable: true, isActive: true, availability: "1111", iconDefault: "Xcode", iconHighlight: "XcodeH"),
        Action(actionName: "Sketch", progressChangeDevelopment: 10, statsChangeKnowledge: 0, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 25, isPickable: true, isActive: true,availability: "1111", iconDefault: "Sketch", iconHighlight: "SketchH"),
        Action(actionName: "Notion", progressChangeDevelopment: 2, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, isPickable: true, isActive: true,availability: "1111", iconDefault: "Notion", iconHighlight: "NotionH"),
        Action(actionName: "Miro", progressChangeDevelopment: 2, statsChangeKnowledge: 5, statsChangeSocial: 5, statsChangeSickness: 5, statsChangeStress: 5, isPickable: true, isActive: true,availability: "1111", iconDefault: "Miro", iconHighlight: "MiroH"),
        Action(actionName: "Zoom", progressChangeDevelopment: 2, statsChangeKnowledge: 15, statsChangeSocial: 10, statsChangeSickness: 15, statsChangeStress: 25, isPickable: true, isActive: true,availability: "1000", iconDefault: "Zoom", iconHighlight: "ZoomH"),
        Action(actionName: "Safari", progressChangeDevelopment: 0, statsChangeKnowledge: 10, statsChangeSocial: -10, statsChangeSickness: 10, statsChangeStress: 5, isPickable: true, isActive: true,availability: "1111", iconDefault: "Safari", iconHighlight: "SafariH"),
        Action(actionName: "Discord", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 5, statsChangeStress: -5, isPickable: true, isActive: true,availability: "0111", iconDefault: "Discord", iconHighlight: "DiscordH"),
        Action(actionName: "Instagram", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 5, statsChangeStress: 5, isPickable: true, isActive: true,availability: "1111", iconDefault: "Instagram", iconHighlight: "InstagramH"),
        Action(actionName: "Netflix", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: 0, statsChangeStress: -15, isPickable: true, isActive: true,availability: "1111", iconDefault: "Netflix", iconHighlight: "NetflixH"),
        Action(actionName: "Game", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 5, statsChangeSickness: 0, statsChangeStress: -15, isPickable: true, isActive: true,availability: "1111", iconDefault: "Game", iconHighlight: "GameH"),
        Action(actionName: "Nap", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -5, statsChangeSickness: -10, statsChangeStress: -10, isPickable: true, isActive: true,availability: "1110", iconDefault: "Nap", iconHighlight: "NapH"),
        Action(actionName: "Sleep", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -5, statsChangeSickness: -30, statsChangeStress: -30, isPickable: true, isActive: true,availability: "0001", iconDefault: "Sleep", iconHighlight: "SleepH")
    ]
    var scene: [Scene] = [
        Scene(sceneId: 1, sceneName: "Development Success!", sceneDescription: "Everything went out smoothly; Development finished on time, and you're living well.", sceneImage: "Scene01", isUnlocked: false)
    ]
    var selectedApp: Int = -1
    var availableAppList: [Action] = []
    var unlockedScene: Scene?
    var notesText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        refreshScreenState()
        actionCollectionView.delegate = self
        actionCollectionView.dataSource = self
        logTextView.text = "Untitled Wellbeing Game.\n"
        // Do any additional setup after loading the view.
    }
    
    func initDesign(){
        developmentProgressView.transform = developmentProgressView.transform.scaledBy(x: 1, y: 18)
        knowledgeProgressView.transform = knowledgeProgressView.transform.scaledBy(x: 1, y: 10)
        socialProgressView.transform = socialProgressView.transform.scaledBy(x: 1, y: 10)
        sicknessProgressView.transform = sicknessProgressView.transform.scaledBy(x: 1, y: 10)
        stressProgressView.transform = stressProgressView.transform.scaledBy(x: 1, y: 10)
        actionActButton.tintColor = .black
        backButton.tintColor = .gray
        
        
        desktopImageView.backgroundColor = .white
        headerView.backgroundColor = UIColor(named: "Window")
        developmentView.backgroundColor = UIColor(named: "Window")
        actionView.backgroundColor = UIColor(named: "Window")
        statusView.backgroundColor = UIColor(named: "Window")
        notesView.backgroundColor = UIColor(named: "Window")
//        actionCollectionView.backgroundColor = UIColor(named: "Window")
        actionCollectionView.backgroundColor = .none

        headerView.layer.borderWidth = 2
        developmentView.layer.borderWidth = 2
        actionView.layer.borderWidth = 2
        statusView.layer.borderWidth = 2
        notesView.layer.borderWidth = 2
//        actionCollectionView.layer.borderWidth = 2

    }
    
    func refreshScreenState(){
        checkAvailableApp()
        resetAction()
        checkState()
        updateBar()
        updateNotes()
        updateColorTimeframe()
        actionCollectionView.reloadData()
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func doAction(_ sender: Any) {
        if selectedApp != -1 {
            player.progressDevelopment += availableAppList[selectedApp].progressChangeDevelopment
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
    
    func doEnding(sceneNumber: Int){
        if !scene[sceneNumber].isUnlocked {
            unlockedScene = scene[sceneNumber]
            scene[sceneNumber].isUnlocked = true
            performSegue(withIdentifier: "gotoCutsceneSegue", sender: self)
        }
    }
    
    func checkState(){
        if player.progressDevelopment == 100 {
            doEnding(sceneNumber: 0)
            notesText.append("Development has been finished! Congratulations!\n")
        }
        
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
        if player.statsSocial < 15 {
            notesText.append("Social is too low! Don't be anti-social.\n")
        }
        if player.statsSickness > 80 {
            notesText.append("Sickness is too high! Have a proper rest.\n")
        }
        if player.statsStress > 80 {
            notesText.append("Stress is too high! Touch grass.\n")
        }
        
    }
    
    func updateNotes(){
        notesTextView.text = notesText
        notesText = ""
    }
    
    func appendLog(){
        logTextView.text.append("\nYou've done \(availableAppList[selectedApp].actionName).")
        if availableAppList[selectedApp].progressChangeDevelopment != 0 {
            logTextView.text.append(" Development increased by \(availableAppList[selectedApp].progressChangeDevelopment)")
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
        
        logTextView.text.append("\nIt's now \(timeframeIntToText(timeframe: player.currentTimeframe)).")
        
        logTextView.scrollRangeToVisible(NSMakeRange(logTextView.text.count, 1))
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
        actionSelectedAppLabel.text = "-"
        actionSelectedAppLabel.textColor = .black
        actionDevelopmentChangeLabel.textColor = .black
        actionDevelopmentChangeLabel.text = "N/A"
        actionKnowledgeChangeLabel.text = "N/A"
        actionSocialChangeLabel.text = "N/A"
        actionSicknessChangeLabel.text = "N/A"
        actionStressChangeLabel.text = "N/A"
        actionActButton.tintColor = .gray
        actionActButton.isUserInteractionEnabled = false
        actionActButton.setTitleColor(.white, for: .normal)
    }
    
    func updateActionStatsChange(selectedAction: Action){
        actionSelectedAppLabel.text = selectedAction.actionName
        actionDevelopmentChangeLabel.text = selectedAction.progressChangeDevelopment > 0 ? "+\(selectedAction.progressChangeDevelopment)" : "\(selectedAction.progressChangeDevelopment)"
        actionKnowledgeChangeLabel.text = selectedAction.statsChangeKnowledge > 0 ? "+\(selectedAction.statsChangeKnowledge)" : "\(selectedAction.statsChangeKnowledge)"
        actionSocialChangeLabel.text = selectedAction.statsChangeSocial > 0 ? "+\(selectedAction.statsChangeSocial)" : "\(selectedAction.statsChangeSocial)"
        actionSicknessChangeLabel.text = selectedAction.statsChangeSickness > 0 ? "+\(selectedAction.statsChangeSickness)" : "\(selectedAction.statsChangeSickness)"
        actionStressChangeLabel.text = selectedAction.statsChangeStress > 0 ? "+\(selectedAction.statsChangeStress)" : "\(selectedAction.statsChangeStress)"
        
        if !selectedAction.isPickable {
            actionDevelopmentChangeLabel.textColor = .red
            actionSelectedAppLabel.textColor = .red
//            actionActButton.setTitleColor(.red, for: .normal)
//            actionActButton.setTitle("Act →", for: .normal)
//            actionActButton.tintColor = .black
        } else {
            actionDevelopmentChangeLabel.textColor = .black
            actionSelectedAppLabel.textColor = .black
//            actionActButton.setTitleColor(.white, for: .normal)
//            actionActButton.setTitle("Act →", for: .normal)
//            actionActButton.tintColor = .gray
        }
        
        if !selectedAction.isActive {
            actionActButton.tintColor = .gray
            actionActButton.isUserInteractionEnabled = false
        } else {
            actionActButton.tintColor = .black
            actionActButton.isUserInteractionEnabled = true
        }
            
    }
    
    func updateColorTimeframe(){
        let timeframeColor = ["BGMorning2", "BGNoon2", "BGDusk2", "BGNight2"]
        UIView.animate(withDuration: 0.5){
//            self.headerView.backgroundColor = UIColor(named: timeframeColor[self.player.currentTimeframe])
            self.view.backgroundColor = UIColor(named: timeframeColor[self.player.currentTimeframe])
        }
    }
    
    func updateBar(){
        headerTimeIndicator.text = "Day \(player.currentDay) - \(timeframeIntToText(timeframe: player.currentTimeframe))"
        
        developmentProgressView.setProgress(Float(player.progressDevelopment)/Float(player.statsUpperLimit), animated: true)
        knowledgeProgressView.setProgress(Float(player.statsKnowledge)/Float(player.statsUpperLimit), animated: true)
        socialProgressView.setProgress(Float(player.statsSocial)/Float(player.statsUpperLimit), animated: true)
        sicknessProgressView.setProgress(Float(player.statsSickness)/Float(player.statsUpperLimit), animated: true)
        stressProgressView.setProgress(Float(player.statsStress)/Float(player.statsUpperLimit), animated: true)
    }
    
    func updateBarNumber(){
//        progressBarDevelopment.text = "\(player.progressDevelopment) / \(player.statsUpperLimit)"
//        statsBarKnowledge.text = "\(player.statsKnowledge) / \(player.statsUpperLimit)"
//        statsBarSocial.text = "\(player.statsSocial) / \(player.statsUpperLimit)"
//        statsBarSickness.text = "\(player.statsSickness) / \(player.statsUpperLimit)"
//        statsBarStress.text = "\(player.statsStress) / \(player.statsUpperLimit)"
        headerTimeIndicator.text = "Day \(player.currentDay) - \(timeframeIntToText(timeframe: player.currentTimeframe))"
    }
    
    func checkAvailableApp(){
        availableAppList.removeAll()
        for act in action {
            var actTemp = act
            let timeframeIndex = actTemp.availability.index(actTemp.availability.startIndex, offsetBy: player.currentTimeframe)
            if actTemp.availability[timeframeIndex] == "1"{
                actTemp.isActive = true
            } else {
                actTemp.isActive = false
            }
            
            actTemp.isPickable = checkPlayerCondition(act: act)
            if actTemp.progressChangeDevelopment > 0 {
                actTemp.progressChangeDevelopment += player.statsKnowledge/20
            }
            if !actTemp.isPickable {
                actTemp.progressChangeDevelopment = Int(Double(actTemp.progressChangeDevelopment) * 0.3)
            }
            availableAppList.append(actTemp)
        }
    }
    
    func checkPlayerCondition(act: Action) -> Bool{
        if player.statsSocial + act.statsChangeSocial < 0 {
            return false
        } else if player.statsSickness + act.statsChangeSickness > 100 {
            return false
        } else if player.statsStress + act.statsChangeStress > 100 {
            return false
        } else {
            return true
        }
    }
//    func barIntToText(progress: Int) -> String{
//        var progressText = ""
//        let progressConvert = max(0, progress/5)
//        for _ in 0...progressConvert {
//            progressText.append("#")
//        }
//        return progressText
//    }
    
    func changeIntToText(change: Int) -> String{
        var changeText = ""
        let isNegative = change < 0 ? true : false
        let changeConvert = max(0, abs(change/5))
        
        if change != 0 {
            for _ in 0...changeConvert {
                changeText.append(isNegative ? "-" : "+")
            }
        } else {
            changeText = "N/A"
        }
        return changeText
    }
    
    func timeframeIntToText(timeframe: Int) -> String{
        let timeframeText = ["Morning 🌄", "Noon ☀️", "Dusk 🌇", "Night 🌙"]
        return timeframeText[timeframe]
    }
    
    
    //MARK: COLLECTION VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableAppList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = actionCollectionView.dequeueReusableCell(withReuseIdentifier: "actionItem", for: indexPath) as! ActionCollectionViewCell
        cell.actionNameLabel.text = availableAppList[index].actionName
        
        if !availableAppList[index].isPickable {
            cell.actionNameLabel.textColor = .red
            cell.actionIconImageView.image = UIImage(systemName: "questionmark.app")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        } else {
            cell.actionNameLabel.textColor = .black
            actionActButton.setTitleColor(.white, for: .normal)
            cell.actionIconImageView.image = UIImage(systemName: "questionmark.app")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
        
        if !availableAppList[index].isActive {
            cell.actionNameLabel.textColor = .gray
            cell.actionIconImageView.image = UIImage(systemName: "questionmark.app.dashed")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        } else {
            cell.actionNameLabel.textColor = .black
            cell.actionIconImageView.image = UIImage(systemName: "questionmark.app")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedApp = indexPath.row
        updateActionStatsChange(selectedAction: availableAppList[selectedApp])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoCutsceneSegue" {
            let destination = segue.destination as? UnlockableViewController
            destination?.unlockedScene = self.unlockedScene
        }
    }
}


