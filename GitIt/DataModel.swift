//
//  DataModel.swift
//  GitIt
//
//  Created by Mohit Garg on 8/19/15.
//  Copyright (c) 2015 Mohit. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    dynamic var eventsData = NSMutableArray()
    
    override init() {
        super.init()
        
       

    }
    
    func getEventsList(){
        let serviceCall = ServiceCall()
        serviceCall.makeServiceCall(NSURL())
        
        serviceCall.serviceResponse = {(response:AnyObject,serviceID:NSNumber) -> () in
            if let result = response as? NSMutableArray{
                self.makeEventObject(result)
            }
        }
    }
    
    func makeEventObject(array: NSMutableArray){
        
        
        let tempEventData = NSMutableArray()
        
        for eventDict in array{
            
            var eventObj = EventObj()
            
            //Get Username
            if let userDict = eventDict["actor"] as? NSDictionary{
                if let userName =  userDict["login"] as? String{
                    eventObj.userName = userName
                }
            }
            
            //Code for title? 
            
            //Get Repository Info
            if let repoDict = eventDict["repo"] as? NSDictionary{
                if let repoName =  repoDict["name"] as? String{
                    eventObj.repositoryName = repoName
                }
            }
            
            tempEventData.addObject(eventObj)
        }
        
        self.eventsData = tempEventData
    }
}
