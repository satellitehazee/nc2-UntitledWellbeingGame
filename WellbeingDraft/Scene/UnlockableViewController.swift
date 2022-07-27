//
//  UnlockableViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 25/07/22.
//

import UIKit

class UnlockableViewController: UIViewController {

    @IBOutlet weak var sceneGreetLabel: UILabel!
    
    @IBOutlet weak var sceneTitleLabel: UILabel!
    @IBOutlet weak var sceneIdLabel: UILabel!
    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var sceneDescriptionTextView: UITextView!
    
    var unlockedScene: Scene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneGreetLabel.text = ""
        
        sceneTitleLabel.text = unlockedScene?.sceneName
        sceneIdLabel.text = "#\(String(describing: unlockedScene?.sceneId))"
        sceneDescriptionTextView.text = unlockedScene?.sceneDescription
        sceneDescriptionTextView.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
}
