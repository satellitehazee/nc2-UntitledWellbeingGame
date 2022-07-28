//
//  MainMenuViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 26/07/22.
//

import UIKit

protocol UpdateGalleryEnding: AnyObject{
    func unlock(sceneNumber: Int)
}

class MainMenuViewController: UIViewController, UpdateGalleryEnding {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var collectionButton: UIButton!
    
    var sceneList: [Scene] = [
        Scene(sceneId: 1, sceneName: "Development Success!", sceneDescription: "Everything went out smoothly; Development finished on time, and you're living well.", sceneImage: "Scene01", isUnlocked: false),
        Scene(sceneId: 2, sceneName: "Presentation", sceneDescription: "You finally presented your app to everyone in the Academy.\nThank you for playing the game!", sceneImage: "Scene02", isUnlocked: false),
        Scene(sceneId: 3, sceneName: "Smart Guy", sceneDescription: "You're always popular.. when it's near deadline.", sceneImage: "Scene03", isUnlocked: false),
        Scene(sceneId: 4, sceneName: "NPC", sceneDescription: "You never socialize that people didn't even know you existed.", sceneImage: "Scene04", isUnlocked: false),
        Scene(sceneId: 5, sceneName: "Stressed out", sceneDescription: "Couldn't handle the stress level, this person exploded.", sceneImage: "Scene05", isUnlocked: false),
        Scene(sceneId: 6, sceneName: "VIP Patient", sceneDescription: "\"Ah, it's that person again!\", said the hospital manager.", sceneImage: "Scene06", isUnlocked: false)
    ]
    
    
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "gotoGameSegue", sender: self)
    }
    @IBAction func collection(_ sender: Any) {
        performSegue(withIdentifier: "gotoCollectionSegue", sender: self)
    }
    
    func unlock(sceneNumber: Int) {
        sceneList[sceneNumber-1].isUnlocked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoGameSegue" {
            let destination = segue.destination as? ViewController
            destination?.sceneList = sceneList
        } else if segue.identifier == "gotoCollectionSegue" {
            let destination = segue.destination as? GalleryViewController
            destination?.scene = sceneList
        }
    }

}
