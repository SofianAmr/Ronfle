//
//  HomeViewController.swift
//  Ronfle
//
//  Created by Soso on 27/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    @IBOutlet weak var quality: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet weak var analyse: UILabel!
    @IBOutlet weak var youWillSleep: UILabel!
    @IBOutlet weak var btn_SetAlarm: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var or: UILabel!
    @IBOutlet weak var buttonBefore: UIButton!
    @IBOutlet weak var buttonAfter: UIButton!
    @IBOutlet weak var modeWorkHoliday: UISegmentedControl!
    @IBOutlet weak var activeAlarm: UISwitch!
    
    var mode: Int = 0
    var saveWorkDate: Date = Date()
    var saveHolidayDate: Date = Date()
    var listSleep = [""]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if activeAlarm.isOn == false {
            let alert = UIAlertController(title: "Active Alarm", message: "If you want to set the Alarm, turn the switch ON", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge], completionHandler: {didAllow, error in
        })
        
        timePicker.setValue(UIColor.white, forKey: "textColor")
        
        save.layer.cornerRadius = 5.0
        save.layer.masksToBounds = true
        
        btn_SetAlarm.layer.cornerRadius = 5.0
        btn_SetAlarm.layer.masksToBounds = true
        
        buttonBefore.layer.cornerRadius = 5.0
        buttonBefore.layer.masksToBounds = true
        
        buttonAfter.layer.cornerRadius = 5.0
        buttonAfter.layer.masksToBounds = true
        
        buttonBefore.isHidden = true
        buttonAfter.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func convertTimeToString(dateTime: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.dateFormat = "HH:mm"
        
        let str = dateFormatter.string(from: dateTime)
        
        return str
    }
    
    func convertTimeToMinutes(dateTime: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour, .minute], from: dateTime)
        let hour = components.hour!
        let minute = components.minute!
        
        let minutes = hour * 60 + minute
        
        return minutes
    }
    
    func convertStringToTime(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: strDate)
        return date!
    }
    
    func convertStringToMinutes(strDate: String) -> Int {
        let date = convertStringToTime(strDate: strDate)
        let minutes = convertTimeToMinutes(dateTime: date)
        
        return minutes
    }
    
    func calculateCycle(interval: TimeInterval) -> (Int, Int) {
        let time = NSInteger(interval)
        
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
        
        minutes = hours * 60 + minutes
        
        let cycle = minutes % 90
        
        return (cycle,minutes)
    }
    
    func determineBestHours(time: Date) -> (String, String) {
        
        let intervalTime = calculateCycle(interval: timePicker.date.timeIntervalSince(time))
        
        let dateBefore = timePicker.date.adding(minutes: -intervalTime.0)
        let dateAfter = timePicker.date.adding(minutes: (90-intervalTime.0))
        
        let strBefore = convertTimeToString(dateTime: dateBefore)
        let strAfter = convertTimeToString(dateTime: dateAfter)
        
        return (strBefore, strAfter)
    }
    
    
    func showQualityAndAnalyse(cycle: Int, minutes: Int, bestHours: (String, String)) {
        analyse.text = ""
        or.text = ""
        
        
        if (cycle < 6 || cycle > 84) && minutes > 6 {
            quality.text = "GOOD"
            quality.textColor = UIColor.green
            analyse.text = "You will wake up feeling energized and refreshed"
        }
        else {
            quality.text = "BAD"
            quality.textColor = UIColor.red
            analyse.text = "You should try to wake at :"
            
            if minutes < 90 {
                buttonAfter.isHidden = false
                buttonBefore.isHidden = false
                buttonBefore.setTitle("", for: .normal)
                buttonAfter.setTitle(bestHours.1, for: .normal)
            }
            else {
                or.text = "OR"
                buttonAfter.isHidden = false
                buttonBefore.isHidden = false
                buttonBefore.setTitle(bestHours.0, for: .normal)
                buttonAfter.setTitle(bestHours.1, for: .normal)
            }
        }
    }
    
    @IBAction func setAlarmBefore(_ sender: Any) {
        let currentDate = Date()
        let sleepTime = currentDate.adding(minutes: 15)
        
        let dateBefore = convertStringToTime(strDate: determineBestHours(time: sleepTime).0)
        let minutesBefore = convertStringToMinutes(strDate: determineBestHours(time: dateBefore).0)
        let minutesPicker = convertTimeToMinutes(dateTime: timePicker.date)
        let difference = minutesPicker - minutesBefore
        let date = timePicker.date.adding(minutes: -difference)
        
        timePicker.setDate(date, animated: true)
    }
    
    @IBAction func setAlarmAfter(_ sender: Any) {
        let currentDate = Date()
        let sleepTime = currentDate.adding(minutes: 15)
        
        let dateAfter = convertStringToTime(strDate: determineBestHours(time: sleepTime).1)
        let minutesAfter = convertStringToMinutes(strDate: determineBestHours(time: dateAfter).1)
        let minutesPicker = convertTimeToMinutes(dateTime: timePicker.date)
        
        let difference = minutesAfter - minutesPicker
        let date = timePicker.date.adding(minutes: difference)
        
        timePicker.setDate(date, animated: true)
    }
    
    @IBAction func saveHour(_ sender: Any) {
        if modeWorkHoliday.selectedSegmentIndex == 0 {
            saveWorkDate = timePicker.date
            let strDate = convertTimeToString(dateTime: saveWorkDate)
            let alert = UIAlertController(title: "\(strDate)", message: "You just saved this hour for work mode !", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            
            
        }
        else {
            saveHolidayDate = timePicker.date
            let strDate = convertTimeToString(dateTime: saveHolidayDate)
            let alert = UIAlertController(title: "\(strDate)", message: "You just saved this hour for holiday mode !", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @IBAction func setModeTIme(_ sender: Any) {
        if modeWorkHoliday.selectedSegmentIndex == 0 {
            timePicker.setDate(saveWorkDate, animated: true)
            print("set work : \(saveWorkDate) \(modeWorkHoliday.selectedSegmentIndex)")
        }
        else {
            timePicker.setDate(saveHolidayDate, animated: true)
            print("set holiday : \(saveHolidayDate) \(modeWorkHoliday.selectedSegmentIndex)")
        }
    }
    
    
    @IBAction func timePickerChanged(_ sender: Any) {}
    
    @IBAction func calculate(_ sender: UIButton) {
        buttonBefore.isHidden = true
        buttonAfter.isHidden = true
        let currentDate = Date()
        let sleepTime = currentDate.adding(minutes: 15)
        let date = timePicker.date

        let strTime = convertTimeToString(dateTime: date)
        var difference = date.timeIntervalSince(sleepTime)
        var duration = difference.stringFromTimeInterval()
        
        let cycle = calculateCycle(interval: difference).0
        let minutes = calculateCycle(interval: difference).1
        
        let content = UNMutableNotificationContent()
        
        if convertTimeToMinutes(dateTime: sleepTime) > convertTimeToMinutes(dateTime: date) && convertTimeToMinutes(dateTime: date) > convertTimeToMinutes(dateTime: currentDate)-1 {
            quality.text = ""
            timeDuration.text = ""
            analyse.text = ""
            or.text = ""
            youWillSleep.text = "You have to set the alarm clock more than 15 minutes away because an average person falls asleep in about 15 minutes"
            
            difference = date.timeIntervalSince(currentDate)
            duration = difference.stringFromTimeInterval()
            
            if activeAlarm.isOn == true {
                
                let alert = UIAlertController(title: "Time to sleep", message: "You just set the alarm for \(strTime)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert,animated: true,completion: nil)
                
                content.subtitle = "\(strTime)"
                content.title = "It's time to wake up !"
                content.sound = UNNotificationSound.default
                
                var interval = difference
                print(interval)
                
                if interval <= 0 {
                    interval = interval + 31536000
                }
                print(interval)
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
                
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                let strQuality = (quality.text)!
                print(strQuality)
                
                let savedSleep = "\(strTime) -> quality : \(strQuality)"
                
//                let path = Bundle.main.path(forResource: "database", ofType: "plist")
//                let url = URL(fileURLWithPath: path!)
//                let obj = NSDictionary(contentsOf: url)
//                let str = obj!.value(forKey: "SESSION_ACTIVE")
                
                global_InsertDb(key: "SLEEP", value: savedSleep)
                
                print("savedsleep : " + savedSleep)
            }

            
        }
        else {
            youWillSleep.text = "If you go to sleep right now and wake up at \(strTime), you will sleep during around : "
            
            difference = date.timeIntervalSince(sleepTime)
            duration = difference.stringFromTimeInterval()
            
            timeDuration.text = duration
            
            showQualityAndAnalyse(cycle: cycle, minutes: minutes, bestHours: determineBestHours(time: sleepTime))

            if activeAlarm.isOn == true {
                
                let alert = UIAlertController(title: "Time to sleep !", message: "You just set the alarm for \(strTime)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert,animated: true,completion: nil)

                content.subtitle = "\(strTime)"
                content.title = "It's time to wake up !"
                content.sound = UNNotificationSound.default
                
                var interval = difference
                
                print(difference)
                print(interval)
                
                if interval <= 0 {
                    interval = interval + 31536000
                }
                print(interval)
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
                
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                let strQuality = (quality.text)!
                print(strQuality)
                
                let savedSleep = "\(strTime) -> quality : \(strQuality)"
                
                listSleep.append(savedSleep)
                
                
                //                let path = Bundle.main.path(forResource: "database", ofType: "plist")
                //                let url = URL(fileURLWithPath: path!)
                //                let obj = NSDictionary(contentsOf: url)
                //                let str = obj!.value(forKey: "SESSION_ACTIVE")
                
                global_InsertDb(key: "SLEEP", value: listSleep.description)
                
                print("savedsleep : " + listSleep.description)
            }
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
