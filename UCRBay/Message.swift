//
//  Message.swift
//  UCRBay
//
//  Created by Emptybubble on 3/5/24.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
    
}
