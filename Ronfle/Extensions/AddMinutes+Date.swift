//
//  Void+Date.swift
//  Ronfle
//
//  Created by Soso on 28/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import Foundation

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
