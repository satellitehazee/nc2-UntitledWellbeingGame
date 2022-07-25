//
//  Player.swift
//  WellbeingDraft
//
//  Created by Hocky on 24/07/22.
//

import Foundation

struct Player: Codable{
    var currentDay: Int
    var currentTimeframe: Int
    var progressDevelopment: Int
    var statsKnowledge: Int
    var statsSocial: Int
    var statsSickness: Int
    var statsStress: Int
    
    var statsUpperLimit: Int
    var statsBottomLimit: Int
    //TODO: trackers, such as action use count
}
