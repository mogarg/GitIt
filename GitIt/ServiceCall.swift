//
//  ServiceCall.swift
//  GitIt
//
//  Created by Mohit Garg on 15/08/15.
//  Copyright (c) 2015 Mohit. All rights reserved.
//

import Foundation

let kBaseURL:String = "https://api.github.com/events"

class ServiceCall: NSObject,NSURLSessionDataDelegate {
    
    
    typealias serviceResponseClosure = (response: AnyObject , serviceID: NSNumber) -> ()
    
    var serviceResponse: serviceResponseClosure = {(response:AnyObject,serviceID:NSNumber) -> () in
        
    }
    
    var eventsData = NSData()
    
    var session:NSURLSession?
    
    override init() {
        super.init()
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
         session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        
    }
    
    func makeServiceCall(url:NSURL){
        let url = NSURL(string: kBaseURL)
        
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "GET"
        
        let dataTask = session?.dataTaskWithRequest(urlRequest)
        dataTask?.resume()
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
            
            var error:NSError?
            
            let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(eventsData, options: NSJSONReadingOptions.allZeros, error:&error)
            
            var datastring = NSString(data: eventsData, encoding: 8)
            
            if(error == nil) {
                dispatch_async(dispatch_get_main_queue(),{
                    self.serviceResponse(response: json!, serviceID: 0)
                })
            }
            else{
                println("Error:\(error) for service id")
        
    }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
        var tempData = NSMutableData(data: eventsData)
        tempData.appendData(data)
        
        self.eventsData = tempData
    }

   
    
}
