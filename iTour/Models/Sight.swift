//
//  Sight.swift
//  iTour
//
//  Created by Margarita Mayer on 16/12/23.
//

import Foundation
import SwiftData

@Model
class Sight {
    
    var name: String
    var destination: Destination?

    init(name: String) {
        self.name = name
    }
    
}
