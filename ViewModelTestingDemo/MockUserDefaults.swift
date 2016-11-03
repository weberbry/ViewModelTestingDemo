//
//  MockUserDefaults.swift
//  ViewModelTestingDemo
//
//  Created by Bryan Weber on 11/2/16.
//  Copyright © 2016 Bryan Weber. All rights reserved.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var defaults: [String: Any] = [:]
    
    override func set(_ value: Bool, forKey defaultName: String) {
        defaults[defaultName] = value
    }
    
    override func bool(forKey defaultName: String) -> Bool {
        guard let boolValue = defaults[defaultName] as? Bool else { return false }
        return boolValue
    }
}
