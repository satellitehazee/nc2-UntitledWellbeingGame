//
//  GalleryViewController.swift
//  WellbeingDraft
//
//  Created by Hocky on 27/07/22.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var galleryTitleLabel: UILabel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var scene: [Scene] = [
        Scene(sceneId: 1, sceneName: "Development Success!", sceneDescription: "Everything went out smoothly; Development finished on time, and you're living well.", sceneImage: "Scene01", isUnlocked: false),
        Scene(sceneId: 2, sceneName: "Development Failed..", sceneDescription: "Everything went out smoothly.. maybe?", sceneImage: "Scene02", isUnlocked: false),
        Scene(sceneId: 3, sceneName: "Smart Guy", sceneDescription: "You're always popular.. when it's near deadline.", sceneImage: "Scene0", isUnlocked: false),
        Scene(sceneId: 4, sceneName: "NPC", sceneDescription: "You never socialize that people didn't even know you existed.", sceneImage: "Scene04", isUnlocked: false),
        Scene(sceneId: 5, sceneName: "Stressed out", sceneDescription: "Couldn't handle the stress level, this person exploded.", sceneImage: "Scene05", isUnlocked: false),
        Scene(sceneId: 6, sceneName: "VIP Patient", sceneDescription: "\"Ah, it's that person again!\", said the hospital manager.", sceneImage: "Scene06", isUnlocked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        print (scene.count)
        print (scene[0].sceneDescription)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scene.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "sceneItem", for: indexPath) as! SceneCollectionViewCell
        cell.sceneTitleLabel.text = "#\(scene[indexPath.row].sceneId): \(scene[index].sceneName)"
        if scene[index].isUnlocked {
            cell.sceneImageView.image = UIImage(systemName: "questionmark.app.fill")
            cell.sceneDescriptionTextView.text = scene[index].sceneDescription
        } else {
            cell.sceneImageView.image = UIImage(systemName: "lock.fill")
            cell.sceneDescriptionTextView.text = "Locked"
        }
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 256, height: 256)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        scene[index].isUnlocked = true
        collectionView.reloadData()
    }
}
