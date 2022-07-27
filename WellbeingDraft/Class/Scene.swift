//
//  Scene.swift
//  WellbeingDraft
//
//  Created by Hocky on 25/07/22.
//

import Foundation

struct Scene: Codable {
    var sceneId: Int
    var sceneName: String
    var sceneDescription: String
    var sceneImage: String
    var isUnlocked: Bool
}
