//
//  Action.swift
//  WellbeingDraft
//
//  Created by Hocky on 24/07/22.
//

import Foundation

struct Action: Codable {
    var actionName: String
    var progressChangeDevelopment: Int
    var statsChangeKnowledge: Int
    var statsChangeSocial: Int
    var statsChangeSickness: Int
    var statsChangeStress: Int
    var isOkay: Bool
    var isActive: Bool
    // use binary; morning-noon-dusk-night
    // example: "1000" = morning exclusive
    var availability: String
    
    var iconDefault: String
    var iconHighlight: String
    
    
}
