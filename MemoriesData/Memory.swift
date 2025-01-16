//
//  Memory.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
//

import Foundation
import SwiftData

@Model
final class Memory {
    var timestamp: Date
    var title: String
    var memoDescription: String?
    
    init(timestamp: Date, title: String, memoDescription: String?) {
        self.timestamp = timestamp
        self.title = title
        self.memoDescription = memoDescription
    }
}
