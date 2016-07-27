//
//  RequestHandlerFile.swift
//  AFNetworking 3.0
//
//  Created by MindLogic Solutions on 25/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import Foundation

func SendServerRequest(type:String,baseURL:String,param:AnyObject, requestCompleted:(suceeded:Bool,msg:String,result: AnyObject) -> ()) -> Void  {
    
    let manager = AFHTTPSessionManager()
    manager.requestSerializer = AFHTTPRequestSerializer()
    manager.responseSerializer = AFHTTPResponseSerializer()
    
    if type == "GET"
    {
        manager.GET("\(baseURL)",
                    parameters: nil, progress:nil,
                    success: {
                        
                        operation, responseObject in
                        var json :AnyObject!
                        json = (try! NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
                        
                        //  print("GetMethod ->\(json)")
                        
                        requestCompleted(suceeded: true, msg: "", result: json)
            },
                    failure: {
                        operation, error in
                        print("Error: " + error.localizedDescription)
                        
                        requestCompleted(suceeded: false, msg: "", result: "")
                        
        })
    }
    else
    {
        manager.POST("\(baseURL)",
                     
                     parameters: param, progress:nil,
                     success: {
                        
                        operation, responseObject in
                        var json :AnyObject!
                        json = (try! NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
                        
                        // print("post method ->\(json)")
                        requestCompleted(suceeded: true, msg: "", result: json)
            },
                     failure: {
                        operation, error in
                        print("Error: " + error.localizedDescription)
                        
                        requestCompleted(suceeded: false, msg: "", result: "")
        })
    }
}