//
//  File.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-17.
//

import Foundation

extension UUID {
    public init(_ intValue: Int) {
        self.init(uuidString: "00000000-0000-0000-0000-\(String(format: "%012x", intValue))")!
    }
}
