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
    
    var scene: [Scene]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scene.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "sceneItem", for: indexPath) as! SceneCollectionViewCell
        cell.sceneTitleLabel.text = "#\(scene[indexPath.row].sceneId): \(scene[index].sceneName)"
        if scene[index].isUnlocked {
            cell.sceneImageView.image = UIImage(named: scene[index].sceneImage)
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
