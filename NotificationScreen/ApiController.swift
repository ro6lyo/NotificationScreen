//
//  ApiController.swift
//  NotificationScreen
//
//  Created by Mehmed Kadir on 10/01/15.
//  Copyright © 2015 Mehmed Kadir. All rights reserved.
//

import UIKit
import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController {
    var delegate: APIControllerProtocol?
    
    func searchYouLocal() {
        print("prepare api result")
        
        let urlPath = "https://www.youlocalapp.com/api/notifications/load/?largeScreen&token=f2908658dc92d32a491d2e5b30aad86e"
        let url = NSURL(string: urlPath)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
           // print("Task completed")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
 
            do
            {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if let results: NSArray = jsonResult["notifications"] as? NSArray {
                    self.delegate?.didReceiveAPIResults(results)
                }
                else {
                    print(error)
                }
            }
                
            catch {
                
            }
        })
        
        task.resume()
        
    }
    
    
    
    
}