//
//  Item.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
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
