//
//  FirstViewController.swift
//  todo
//
//  Created by ghostpotato on 5/22/16.
//  Copyright © 2016 ghostpotato. All rights reserved.
//

import UIKit

var isEdit = Bool()

var cellNum = Int()

var listOfTasks = [[String(),String(),String()]]

var firstLoad = Bool()

var fileSize = Int64()

var firstRunEver = Bool()

var dateFromLabel = String()

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var itemIsSelected = Bool()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemIsSelected = true
        cellNum = indexPath.row
        print(cellNum)
    }
    
    @IBAction func edit(_ sender: AnyObject) {
        if itemIsSelected == true {
            isEdit = true
            dateFromLabel = listOfTasks[cellNum][2]
            performSegue(withIdentifier: "First", sender: FirstViewController())
        } else {
            let alertController = UIAlertController(title: "About the Edit button", message: "Select a row and press Edit to edit that row.", preferredStyle: .alert)
            
            let yesAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(yesAlert)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func add(_ sender: AnyObject) {
        let firstViewController = self.storyboard!.instantiateViewController(withIdentifier: "First") as! FirstViewController
        
        self.navigationController!.pushViewController(firstViewController, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath)->CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomTableViewCell", for: indexPath) as! MyCustomTableViewCell
        
        cell.title.text = listOfTasks[indexPath.row][0]
        cell.subtitle.text = listOfTasks[indexPath.row][1]
        cell.date.text = listOfTasks[indexPath.row][2]
        print(listOfTasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if (editingStyle == UITableViewCellEditingStyle.delete){
            listOfTasks.remove(at: indexPath.row)
            table.reloadData()
            itemIsSelected = false
            if listOfTasks.isEmpty {
                table.isHidden = true
            } else {
                table.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad == false {
            do {
                let fileAttributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
                let fileSizeNumber = fileAttributes[FileAttributeKey.size] as! NSNumber
                fileSize = fileSizeNumber.int64Value
            } catch _ as NSError {
                print("Filesize reading failed")
            }
            if fileSize != 0 {
                listOfTasks = NSArray(contentsOf: fileURL)! as! [Array<String>]
            } else {
                firstRunEver = true
            }
            firstLoad = true
        }
        table.reloadData()
        if listOfTasks.isEmpty {
            table.isHidden = true
        } else {
            table.isHidden = false
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        if listOfTasks.isEmpty {
            table.isHidden = true
        } else {
            table.isHidden = false
        }
        table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstRunEver == true {
            let alertController = UIAlertController(title: "Welcome to Todo List!", message: "Press + to add an item. Edit an item by selecting its row and pressing the Edit button.", preferredStyle: .alert)
        
            let yesAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
        
            alertController.addAction(yesAlert)
        
            self.present(alertController, animated: true, completion: nil)
            
            firstRunEver = false
        }
    }
}

