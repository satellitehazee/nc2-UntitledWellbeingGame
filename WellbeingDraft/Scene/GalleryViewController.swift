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
        Scene(sceneId: 1, sceneName: "Development Success!", sceneDescription: "Everything went out smoothly; Development finished on time, and you're living well.", sceneImage: "Scene01", isUnlocked: true),
        Scene(sceneId: 2, sceneName: "Development Failed!", sceneDescription: "Everything went out smoothly; Development finished on time, and you're living well.", sceneImage: "Scene01", isUnlocked: false)
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
        print("#\(scene[indexPath.row].sceneId): \(scene[index].sceneName)")
        cell.sceneTitleLabel.text = "#\(scene[indexPath.row].sceneId): \(scene[index].sceneName)"
        if scene[index].isUnlocked {
            cell.sceneImageView.image = UIImage(systemName: "questionmark.app.fill")
            cell.sceneDescriptionTextView.text = scene[index].sceneDescription
        } else {
            cell.sceneImageView.image = UIImage(systemName: "lock.fill")
            cell.sceneDescriptionTextView.text = "Locked"
        }
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 256, height: 256)
    }
}
