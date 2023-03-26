//
//  DataController.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/25/23.
//

import CoreData

struct DataController {
    static let shared = DataController()
    
    static var preview: DataController {
        return DataController()
    }
    
    init(inMemory: Bool = false) {
        
    }
}
