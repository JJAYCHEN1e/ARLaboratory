//
//  Persistence.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import CoreData

import Foundation
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "ARLaboratory")
        container.loadPersistentStores{(storeDescriotion,error) in
            if let error = error as Error? {
                fatalError("Unsolved Error; \(error)")
            }
            
            
        }
    }
}
