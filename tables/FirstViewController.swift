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

var listOfTasks : [(String,String,String)] = []

var loadedLOT = 0

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var itemIsSelected = Bool()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        itemIsSelected = true
        cellNum = indexPath.row
        print(cellNum)
    }
    
    @IBAction func edit(sender: AnyObject) {
        if itemIsSelected == true {
            isEdit = true
            performSegueWithIdentifier("First", sender: FirstViewController())
        } else {
            let alertController = UIAlertController(title: "About the Edit button", message: "Select a row and press Edit to edit that row.", preferredStyle: .Alert)
            
            let yesAlert = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in print("This has to be here or I can't compile :P") }
            
            alertController.addAction(yesAlert)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func add(sender: AnyObject) {
        let firstViewController = self.storyboard!.instantiateViewControllerWithIdentifier("First") as! FirstViewController
        
        self.navigationController!.pushViewController(firstViewController, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomTableViewCell", forIndexPath: indexPath) as! MyCustomTableViewCell
        
        cell.title.text = listOfTasks[indexPath.row].0
        cell.subtitle.text = listOfTasks[indexPath.row].1
        cell.date.text = listOfTasks[indexPath.row].2
        print(listOfTasks[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            listOfTasks.removeAtIndex(indexPath.row)
            table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loadedLOT == 0 {
            listOfTasks = [ ("Hey There","Welcome","12:00"), ("Hi","Hello","1:00") ]
            loadedLOT = loadedLOT + 1
        }
        self.table.registerClass(MyCustomTableViewCell.self, forCellReuseIdentifier: "MyCustomTableViewCell")
        table.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.table.reloadData()
    }
}

