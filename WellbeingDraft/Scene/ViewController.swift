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
    
    @IBOutlet weak var headerDayCount: UILabel!
    @IBOutlet weak var headerTimeframe: UILabel!
    @IBOutlet weak var timeframeMorningView: UIView!
    @IBOutlet weak var timeframeNoonView: UIView!
    @IBOutlet weak var timeframeDuskView: UIView!
    @IBOutlet weak var timeframeNightView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var knowledgeProgressView: UIProgressView!
    @IBOutlet weak var socialProgressView: UIProgressView!
    @IBOutlet weak var sicknessProgressView: UIProgressView!
    @IBOutlet weak var stressProgressView: UIProgressView!
    
    @IBOutlet weak var developmentProgressView: UIProgressView!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var actionHeaderLabel: UILabel!
    @IBOutlet weak var actionCollectionView: UICollectionView!
    @IBOutlet weak var actionSelectedAppIconImageView: UIImageView!
    @IBOutlet weak var actionSelectedAppLabel: UILabel!
    @IBOutlet weak var actionActButton: UIButton!
    @IBOutlet weak var actionStatsChangeView: UIView!
    
    @IBOutlet weak var actionDevelopmentChangeLabel: UILabel!
    @IBOutlet weak var actionKnowledgeChangeLabel: UILabel!
    @IBOutlet weak var actionSocialChangeLabel: UILabel!
    @IBOutlet weak var actionSicknessChangeLabel: UILabel!
    @IBOutlet weak var actionStressChangeLabel: UILabel!

    
    let statsList = ["Knowledge", "Social", "Sickness", "Stress"]
    
    var player: Player = Player(currentDay: 1, finishDay: 7, currentTimeframe: 0, progressDevelopment: 8, statsKnowledge: 15, statsSocial: 50, statsSickness: 30, statsStress: 25, statsUpperLimit: 100, statsBottomLimit: 0)
    var action: [Action] = [
        Action(actionName: "Xcode", progressChangeDevelopment: 10, statsChangeKnowledge: 2, statsChangeSocial: -15, statsChangeSickness: 15, statsChangeStress: 25, isOkay: true, isActive: true, availability: "1111", iconDefault: "Xcode", iconHighlight: "XcodeH"),
        Action(actionName: "Sketch", progressChangeDevelopment: 10, statsChangeKnowledge: 2, statsChangeSocial: -15, statsChangeSickness: 20, statsChangeStress: 20, isOkay: true, isActive: true,availability: "1111", iconDefault: "Sketch", iconHighlight: "SketchH"),
        Action(actionName: "Notion", progressChangeDevelopment: 5, statsChangeKnowledge: 3, statsChangeSocial: 5, statsChangeSickness: 10, statsChangeStress: 10, isOkay: true, isActive: true,availability: "1111", iconDefault: "Notion", iconHighlight: "NotionH"),
        Action(actionName: "Miro", progressChangeDevelopment: 5, statsChangeKnowledge: 3, statsChangeSocial: 5, statsChangeSickness: 10, statsChangeStress: 10, isOkay: true, isActive: true,availability: "1111", iconDefault: "Miro", iconHighlight: "MiroH"),
        Action(actionName: "Zoom", progressChangeDevelopment: 2, statsChangeKnowledge: 15, statsChangeSocial: 5, statsChangeSickness: 20, statsChangeStress: 25, isOkay: true, isActive: true,availability: "1000", iconDefault: "Zoom", iconHighlight: "ZoomH"),
        Action(actionName: "Safari", progressChangeDevelopment: 0, statsChangeKnowledge: 7, statsChangeSocial: -10, statsChangeSickness: 10, statsChangeStress: 5, isOkay: true, isActive: true,availability: "1111", iconDefault: "Safari", iconHighlight: "SafariH"),
        Action(actionName: "Discord", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 2, statsChangeStress: 3, isOkay: true, isActive: true,availability: "0111", iconDefault: "Discord", iconHighlight: "DiscordH"),
        Action(actionName: "Instagram", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 15, statsChangeSickness: 2, statsChangeStress: 3, isOkay: true, isActive: true,availability: "0111", iconDefault: "Instagram", iconHighlight: "InstagramH"),
        Action(actionName: "Netflix", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 0, statsChangeSickness: 0, statsChangeStress: -15, isOkay: true, isActive: true,availability: "0111", iconDefault: "Netflix", iconHighlight: "NetflixH"),
        Action(actionName: "Game", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: 5, statsChangeSickness: 3, statsChangeStress: -15, isOkay: true, isActive: true,availability: "0111", iconDefault: "Game", iconHighlight: "GameH"),
        Action(actionName: "Nap", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -3, statsChangeSickness: -15, statsChangeStress: -15, isOkay: true, isActive: true,availability: "1110", iconDefault: "Nap", iconHighlight: "NapH"),
        Action(actionName: "Sleep", progressChangeDevelopment: 0, statsChangeKnowledge: 0, statsChangeSocial: -3, statsChangeSickness: -30, statsChangeStress: -30, isOkay: true, isActive: true,availability: "0001", iconDefault: "Sleep", iconHighlight: "SleepH")
    ]
    var sceneList: [Scene]!
    var selectedApp: Int = -1
    var availableAppList: [Action] = []
    var unlockedScene: Scene?
    var notesText: String = ""
    var delegate: UpdateGalleryEnding?
    
    var antisocialCount: Int = 0
    var stressCount: Int = 0
    var sicknessCount: Int = 0
    
    var endGame: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        refreshScreenState()
        actionCollectionView.delegate = self
        actionCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.passScene(newSceneList: sceneList)
    }
    
    func initDesign(){
        developmentProgressView.transform = developmentProgressView.transform.scaledBy(x: 1, y: 18)
        knowledgeProgressView.transform = knowledgeProgressView.transform.scaledBy(x: 1, y: 10)
        socialProgressView.transform = socialProgressView.transform.scaledBy(x: 1, y: 10)
        sicknessProgressView.transform = sicknessProgressView.transform.scaledBy(x: 1, y: 10)
        stressProgressView.transform = stressProgressView.transform.scaledBy(x: 1, y: 10)
        
        actionActButton.tintColor = .black
        backButton.tintColor = .gray
        
        
        desktopImageView.backgroundColor = UIColor(named: "Desktop")
        headerView.backgroundColor = UIColor(named: "Window")
        developmentView.backgroundColor = UIColor(named: "Window")
        actionView.backgroundColor = UIColor(named: "Window")
        statusView.backgroundColor = UIColor(named: "Window")
        notesView.backgroundColor = UIColor(named: "Window")
//        actionCollectionView.backgroundColor = UIColor(named: "Window")
        actionCollectionView.backgroundColor = .none
        
        headerView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        developmentView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        actionView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        statusView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        notesView.layer.borderColor = UIColor(named: "Accent")?.cgColor

        headerView.layer.borderWidth = 2
        developmentView.layer.borderWidth = 2
        actionView.layer.borderWidth = 2
        statusView.layer.borderWidth = 2
        notesView.layer.borderWidth = 2
        
//        actionCollectionView.layer.borderWidth = 2
        
//        headerView.layer.cornerRadius = 10
//        developmentView.layer.cornerRadius = 10
//        actionView.layer.cornerRadius = 10
//        statusView.layer.cornerRadius = 10
//        notesView.layer.cornerRadius = 10
//
//        timeframeMorningView.layer.cornerRadius = 3
//        timeframeNoonView.layer.cornerRadius = 3
//        timeframeDuskView.layer.cornerRadius = 3
//        timeframeNightView.layer.cornerRadius = 3
        
        timeframeMorningView.backgroundColor = .white
        timeframeNoonView.backgroundColor = .white
        timeframeDuskView.backgroundColor = .white
        timeframeNightView.backgroundColor = .white
        
        timeframeMorningView.layer.borderWidth = 1
        timeframeNoonView.layer.borderWidth = 1
        timeframeDuskView.layer.borderWidth = 1
        timeframeNightView.layer.borderWidth = 1
        
        timeframeMorningView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        timeframeNoonView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        timeframeDuskView.layer.borderColor = UIColor(named: "Accent")?.cgColor
        timeframeNightView.layer.borderColor = UIColor(named: "Accent")?.cgColor

    }
    
    func refreshScreenState(){
        checkAvailableApp()
        resetAction()
        checkState()
        updateBar()
        updateNotes()
        updateColorTimeframe()
        actionCollectionView.reloadData()
        if endGame {
            finishGame()
        }
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
            
//            appendLog()
        }
        
        if !endGame {
            refreshScreenState()
        } else {
            actionActButton.isUserInteractionEnabled = false
            actionActButton.tintColor = .gray
            actionSelectedAppLabel.text = "Finished!"
            actionSelectedAppIconImageView.image = .none
            doEnding(sceneNumber: 1)
        }
        
    }
    
    func doEnding(sceneNumber: Int){
        let sceneIndex = sceneNumber - 1
        if !sceneList[sceneIndex].isUnlocked {
            unlockedScene = sceneList[sceneIndex]
            sceneList[sceneIndex].isUnlocked = true
            performSegue(withIdentifier: "gotoCutsceneSegue", sender: self)
        }
    }
    
    func finishGame(){
        actionHeaderLabel.text = ""
        actionActButton.tintColor = .black
//        actionActButton.setTitle("Present →", for: .normal)
//        actionActButton.titleLabel?.font = UIFont(name: "zpix", size: 24)
        
        actionActButton.isUserInteractionEnabled = true
        actionCollectionView.isUserInteractionEnabled = false
        actionStatsChangeView.layer.opacity = 0
        actionSelectedAppLabel.text = "Presentation"
        actionSelectedAppIconImageView.image = UIImage(named: "Keynote")
    }
    
    func checkState(){
        var endingNum = -1
        
        if player.progressDevelopment == 100 && !sceneList[0].isUnlocked {
            endingNum = 2
            notesText.append("Development has been finished!\n You may continue development until final day.\n")
        }
        
        if player.currentDay == 1 {
            notesText.append("It's your last sprint!\n")
            notesText.append("Fill out the development bar by the end of day 7.\n")
            notesText.append("..and make sure to manage your stats wisely.\n\n")
        }
        if player.currentDay == 4 {
            notesText.append("3 days left until deadline..\n")
        }
        if player.currentDay == player.finishDay {
            notesText.append("Almost there! Make sure to finish your development!\n")
        }
        
        if player.statsSocial < 15 {
            notesText.append("Social is too low! Don't be anti-social.\n")
            antisocialCount += 1
        }
        if player.statsSickness > 80 {
            notesText.append("Sickness is too high! Have a proper rest.\n")
            sicknessCount += 1
        }
        if player.statsStress > 80 {
            notesText.append("Stress is too high! Don't push yourself.\n")
            stressCount += 1
        }
        
        if player.statsKnowledge == 100 && !sceneList[2].isUnlocked{
            endingNum = 3
        }
        if antisocialCount > 4 && !sceneList[3].isUnlocked{
            endingNum = 4
        }
        if sicknessCount > 4 && !sceneList[4].isUnlocked{
            endingNum = 5
        }
        if stressCount > 4 && !sceneList[5].isUnlocked{
            endingNum = 6
        }
        
        if player.currentDay > player.finishDay {
            endGame = true
            notesText = "You have finished your sprint.\nIt's time to present your app!"
        }
        
        
        if endingNum != -1 && !endGame{
            doEnding(sceneNumber: endingNum)
        }
        
    }
    
    func updateNotes(){
        notesTextView.text = notesText
        notesText = ""
    }
    
//    func appendLog(){
//        logTextView.text.append("\nYou've done \(availableAppList[selectedApp].actionName).")
//        if availableAppList[selectedApp].progressChangeDevelopment != 0 {
//            logTextView.text.append(" Development increased by \(availableAppList[selectedApp].progressChangeDevelopment)")
//        }
//
//        let changes = [availableAppList[selectedApp].statsChangeKnowledge, availableAppList[selectedApp].statsChangeSocial, availableAppList[selectedApp].statsChangeSickness, availableAppList[selectedApp].statsChangeStress]
//
//        for i in 0...3{
//            if changes[i] != 0 {
//                if changes[i] > 0 {
//                    logTextView.text.append("\n\(statsList[i]) increased by \(changes[i]).")
//                } else {
//                    logTextView.text.append("\n\(statsList[i]) decreased by \(changes[i] * -1).")
//                }
//
//            } else {
//                logTextView.text.append("\nNo changes to \(statsList[i]).")
//            }
//        }
//
//        logTextView.text.append("\nIt's now \(timeframeIntToText(timeframe: player.currentTimeframe)).")
//
//        logTextView.scrollRangeToVisible(NSMakeRange(logTextView.text.count, 1))
//    }
//
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
        actionSelectedAppIconImageView.image = UIImage(named: "Unselected")
//        actionSelectedAppIconImageView.image = UIImage(named: "PlaceholderIcon")
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
        actionSelectedAppIconImageView.image = UIImage(named: selectedAction.iconDefault)
        actionDevelopmentChangeLabel.text = selectedAction.progressChangeDevelopment > 0 ? "+\(selectedAction.progressChangeDevelopment)" : "\(selectedAction.progressChangeDevelopment)"
        actionKnowledgeChangeLabel.text = selectedAction.statsChangeKnowledge > 0 ? "+\(selectedAction.statsChangeKnowledge)" : "\(selectedAction.statsChangeKnowledge)"
        actionSocialChangeLabel.text = selectedAction.statsChangeSocial > 0 ? "+\(selectedAction.statsChangeSocial)" : "\(selectedAction.statsChangeSocial)"
        actionSicknessChangeLabel.text = selectedAction.statsChangeSickness > 0 ? "+\(selectedAction.statsChangeSickness)" : "\(selectedAction.statsChangeSickness)"
        actionStressChangeLabel.text = selectedAction.statsChangeStress > 0 ? "+\(selectedAction.statsChangeStress)" : "\(selectedAction.statsChangeStress)"
        
        if !selectedAction.isOkay {
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
            actionSelectedAppIconImageView.layer.opacity = 0.3
            actionStatsChangeView.layer.opacity = 0.3
            actionSelectedAppLabel.textColor = .gray
            actionActButton.tintColor = .gray
            actionActButton.isUserInteractionEnabled = false
        } else {
            actionSelectedAppIconImageView.layer.opacity = 1
            actionStatsChangeView.layer.opacity = 1
            actionSelectedAppLabel.textColor = .black
            actionActButton.tintColor = .black
            actionActButton.isUserInteractionEnabled = true
        }
        
            
    }
    
    func updateColorTimeframe(){
        let timeframeColor = ["BGMorning2", "BGNoon2", "BGDusk2", "BGNight2"]
        let timeframeView = [timeframeMorningView, timeframeNoonView, timeframeDuskView, timeframeNightView]
        UIView.animate(withDuration: 0.5){ [self] in
//            self.headerView.backgroundColor = UIColor(named: timeframeColor[self.player.currentTimeframe])
            self.view.backgroundColor = UIColor(named: timeframeColor[self.player.currentTimeframe])
            for i in 0...3{
                if i == self.player.currentTimeframe {
                    timeframeView[player.currentTimeframe]?.backgroundColor = UIColor(named: timeframeColor[self.player.currentTimeframe])
                } else {
                    timeframeView[i]?.backgroundColor = .white
                }
            }
            
        }
    }
    
    func updateBar(){
        if player.currentDay < player.finishDay {
            headerDayCount.text = "Day \(player.currentDay) / \(player.finishDay)"
        } else if player.currentDay == player.finishDay {
            headerDayCount.text = "Final day!"
        } else {
            headerDayCount.text = "Presentation day!"
        }
        
        headerTimeframe.text = "\(timeframeIntToText(timeframe: player.currentTimeframe))"
        
        developmentProgressView.setProgress(Float(player.progressDevelopment)/Float(player.statsUpperLimit), animated: true)
        knowledgeProgressView.setProgress(Float(player.statsKnowledge)/Float(player.statsUpperLimit), animated: true)
        socialProgressView.setProgress(Float(player.statsSocial)/Float(player.statsUpperLimit), animated: true)
        sicknessProgressView.setProgress(Float(player.statsSickness)/Float(player.statsUpperLimit), animated: true)
        stressProgressView.setProgress(Float(player.statsStress)/Float(player.statsUpperLimit), animated: true)
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
            if actTemp.progressChangeDevelopment > 0 {
                actTemp.isOkay = checkPlayerCondition(act: act)
                actTemp.progressChangeDevelopment += player.statsKnowledge/20
            }
            if !actTemp.isOkay {
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
//        let timeframeText = ["Morning 🌄", "Noon ☀️", "Dusk 🌇", "Night 🌙"]
        let timeframeText = ["Morning", "Noon", "Dusk", "Night"]
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
        
        cell.actionIconImageView.image = UIImage(named: availableAppList[index].iconDefault)
        cell.layer.borderWidth = 0
        
        if !availableAppList[index].isActive {
            cell.actionNameLabel.textColor = .gray
            cell.actionIconImageView.layer.opacity = 0.3
        } else if !availableAppList[index].isOkay{
            cell.actionNameLabel.textColor = .red
            cell.actionIconImageView.layer.opacity = 1
        } else {
            cell.actionNameLabel.textColor = .black
            cell.actionIconImageView.layer.opacity = 1
        }
        
        if endGame {
            cell.actionNameLabel.textColor = .gray
            cell.actionIconImageView.layer.opacity = 0.3
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedApp = indexPath.row
        let cell = actionCollectionView.cellForItem(at: indexPath) as! ActionCollectionViewCell
        cell.actionIconImageView.image = UIImage(named: availableAppList[selectedApp].iconHighlight)
        cell.layer.borderColor = UIColor(named: "Accent")?.cgColor
        cell.layer.borderWidth = 1
        updateActionStatsChange(selectedAction: availableAppList[selectedApp])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = actionCollectionView.cellForItem(at: indexPath) as! ActionCollectionViewCell
        cell.actionIconImageView.image = UIImage(named: availableAppList[selectedApp].iconDefault)
        cell.layer.borderWidth = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoCutsceneSegue" {
            let destination = segue.destination as? UnlockableViewController
            destination?.unlockedScene = self.unlockedScene
        }
    }
}


