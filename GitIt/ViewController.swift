//
//  ViewController.swift
//  GitIt
//
//  Created by Mohit Garg on 15/08/15.
//  Copyright (c) 2015 Mohit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var eventList: UITableView!
 
    var dataModel = DataModel()
    
    var dataForList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        dataModel.addObserver(self, forKeyPath: "eventsData", options: NSKeyValueObservingOptions.New, context: nil)
        
        dataModel.getEventsList()
        
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == "eventsData"){
            if let dataList = change["new"] as? NSMutableArray{
                dataForList = dataList
                
                self.eventList.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventCell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! EventCell
        
        if let eventObj = dataForList.objectAtIndex(indexPath.row) as? EventObj{
            cell.userLabel.text = eventObj.userName
            cell.repoLabel.text = eventObj.repositoryName
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

