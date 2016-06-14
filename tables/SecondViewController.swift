//
//  SecondViewController.swift
//  todo
//
//  Created by ghostpotato on 5/22/16.
//  Copyright © 2016 ghostpotato. All rights reserved.
//

import UIKit

var loadedBefore = false

let dateFormatter = NSDateFormatter()

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateString = String()
    
    var stringDate = NSDate()
    
    func convertDatePicker() {
        dateString = dateFormatter.stringFromDate(datePicker.date)
        if isEdit == true {
            stringDate = dateFormatter.dateFromString(dateFromLabel)!
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func save(sender: AnyObject) {
        if isEdit == true {
            convertDatePicker()
            if name.text!.isEmpty {
                
            } else {
                listOfTasks.removeAtIndex(cellNum)
                listOfTasks.append([name.text!,desc.text!,dateString])
                isEdit = false
            }
        } else {
            convertDatePicker()
            if name.text!.isEmpty {
                
            } else {
                listOfTasks.append([name.text!,desc.text!,dateString])
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "Second" {
            if (name.text!.isEmpty) {
                
                let alertController = UIAlertController(title: "Add a name!", message: "", preferredStyle: .Alert)
                
                let yesAlert = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alertController.addAction(yesAlert)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                if listOfTasks.isEmpty {
                } else {
                    listOfTasks.removeLast()
                }
                
                return false
            }
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loadedBefore == false {
            dateFormatter.dateFormat = "E h:mm a"
            dateFormatter.AMSymbol = "AM"
            dateFormatter.PMSymbol = "PM"
            loadedBefore = true
            print(datePicker.date)
        }
        if isEdit == true {
            convertDatePicker()
            topLabel.text = "Edit this item"
            name.text = listOfTasks[cellNum][0]
            desc.text = listOfTasks[cellNum][1]
            datePicker.date = stringDate
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let currentDate: NSDate = NSDate()
        
        //let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(name: "UTC")!
        
        let components: NSDateComponents = NSDateComponents()
        components.calendar = calendar
        
        components.day = +0
        let minDate: NSDate = calendar.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        
        components.day = +7
        let maxDate: NSDate = calendar.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        
        print("minDate: \(minDate)")
        print("maxDate: \(maxDate)")
        
        print(self.datePicker)
        
        self.datePicker.minimumDate = minDate
        self.datePicker.maximumDate = maxDate
        
        print(datePicker.minimumDate)
        print(datePicker.maximumDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

