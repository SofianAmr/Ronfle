//
//  String+TimeInterval.swift
//  Ronfle
//
//  Created by Soso on 28/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import Foundation

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        
        var minutes = (time/60)%60
        var hours = time/3600
        
        if hours == 0 && minutes < 0 {
            hours = 23
            minutes = 60 + minutes
        }
        else if minutes == 0 && hours < 0 {
            minutes = 59
            hours = 24 + hours
        }
        else if minutes < 0 && hours < 0 {
            minutes = 60 + minutes
            hours = 23 + hours
        }
        else {
            if minutes < 0 {
                minutes = 60 + minutes
            }
            if hours < 0 {
                hours = 24 + hours
            }
        }
        
        return String(format: "%0.2d:%0.2d",hours,minutes)
        /*
        if (minutes == 0 && hours == 0) {
            return String(format: "%0.2d minutes",minutes)
        }
        else if hours == 1 && minutes == 0 {
            return String(format: "%0.2d hour",hours)
        }
        else if minutes == 1 && hours == 0 {
            return String(format: "%0.2d minute",minutes)
        }
        else if minutes == 1 && hours == 1 {
            return String(format: "%0.2d hour and %0.2d minute",hours,minutes)
        }
        else if hours == 1 && minutes > 1 {
            return String(format: "%0.2d hour and %0.2d minutes",hours,minutes)
        }
        else if minutes == 1 && hours > 1 {
            return String(format: "%0.2d hours and %0.2d minute",hours,minutes)
        }
        else if hours == 0 && minutes > 1 {
            return String(format: "%0.2d minutes",minutes)
        }
        else if minutes == 0 && hours > 1 {
            return String(format: "%0.2d hours",hours)
        }
        else {
            return String(format: "%0.2d hours and %0.2d minutes",hours,minutes)
        }
        */
    }
}
