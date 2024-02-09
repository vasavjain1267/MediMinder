//
//  Item.swift
//  MediMinder
//
//  Created by Vasav Jain on 09/02/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
