//
//  Date+Ext.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-27.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

extension Date {
    var isPastDate: Bool {
        return self < Date()
    }
}
