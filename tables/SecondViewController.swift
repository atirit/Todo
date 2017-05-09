//
//  SecondViewController.swift
//  todo
//
//  Created by ghostpotato on 5/22/16.
//  Copyright © 2016 ghostpotato. All rights reserved.
//

import UIKit

var loadedBefore = false

let dateFormatter = DateFormatter()

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateString = String()
    
    var stringDate = Date()
    
    func convertDatePicker() {
        dateString = dateFormatter.string(from: datePicker.date)
        if isEdit == true {
            stringDate = dateFormatter.date(from: dateFromLabel)!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if isEdit == true {
            convertDatePicker()
            if name.text!.isEmpty {
                
            } else {
                listOfTasks.remove(at: cellNum)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Second" {
            if (name.text!.isEmpty) {
                
                let alertController = UIAlertController(title: "Add a name!", message: "", preferredStyle: .alert)
                
                let yesAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(yesAlert)
                
                self.present(alertController, animated: true, completion: nil)
                
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
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
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
    
    override func viewWillAppear(_ animated: Bool) {
        let currentDate: Date = Date()
        
        //let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var calendar: Calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        var components: DateComponents = DateComponents()
        (components as NSDateComponents).calendar = calendar
        
        components.day = 0
        let minDate: Date = (calendar as NSCalendar).date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        components.day = components.day! + 7
        let maxDate: Date = (calendar as NSCalendar).date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        print("minDate: \(minDate)")
        print("maxDate: \(maxDate)")
        
        print(self.datePicker)
        
        self.datePicker.minimumDate = minDate
        self.datePicker.maximumDate = maxDate
        
        print(datePicker.minimumDate!)
        print(datePicker.maximumDate!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

