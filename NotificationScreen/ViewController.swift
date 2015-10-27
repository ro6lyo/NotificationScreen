//
//  ViewController.swift
//  NotificationScreen
//
//  Created by Mehmed Kadir on 9/30/15.
//  Copyright © 2015 Mehmed Kadir. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    
    let api = APIController()
    var tableData = []
    var notificationInfo = String()
    var tableData1 = [NSDictionary]()
    var tableView: UITableView  =   UITableView()
    var imageCache = [String:UIImage]()
    var singleImage = UIImageView()
    
    var date = NSDate()
    var dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 60))
        let image =  UIImage(named:"gradient")
        navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lato-Regular", size:30)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        let navigationItem = UINavigationItem()
        navigationItem.title = "Notifications"
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        api.delegate = self
        api.searchYouLocal()
        
        tableView.frame = CGRectMake(1, 61, 370, 600);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.view.addSubview(tableView)
        
        dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdendifier: String = "CustomCell"
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier(cellIdendifier, forIndexPath: indexPath) as! CustomCell
        print("vutre v  table view")
        
        if let rowData: NSDictionary = self.tableData1[indexPath.row],
            urlString = rowData["avatar_50"] as? String,
            imgURL = NSURL(string: urlString),
            message = rowData["message"] as? String,
            fullName = rowData["fullname"] as? String,
            dateString = rowData["notificationDate"] as? String
        {
            let dateValue = dateFormatter.dateFromString(dateString) as NSDate!
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            
            var datecomponenets = calendar.components(NSCalendarUnit.Minute , fromDate: dateValue, toDate: today, options: [])
            let minute = datecomponenets.minute
            datecomponenets = calendar.components(NSCalendarUnit.Hour , fromDate: dateValue, toDate: today, options: [])
            let hours = datecomponenets.hour
            datecomponenets = calendar.components(NSCalendarUnit.Day , fromDate: dateValue, toDate: today, options: [])
            let days = datecomponenets.day
           
            if minute <= 60 {
                cell.clockInterval.text = ("\(minute.description)m")
            }
            else {
                if hours <= 24 {
                    cell.clockInterval.text = ("\(hours.description)h")
                    
                }
                else {
                    cell.clockInterval.text = ("\(days.description)d")
                }
            }
            
            if rowData["notificationTypeText"] as? String == "liked your post" {
                notificationInfo = "liked your post"
                singleImage.image = UIImage(named: "icon-notifications-like")
                cell.message.text = " "
            }
            else
                
            {
                if rowData["notificationTypeText"] as? String == "commented on your post" {
                    notificationInfo = "commented your post:"
                    singleImage.image = UIImage(named: "icon-notifications-comment")
                    cell.message.text = ("\(message) ")
                    cell.message.lineBreakMode = .ByWordWrapping
                    cell.message.numberOfLines = 0
                }
                    
                else {
                    if rowData["notificationTypeText"] as? String == "commented on" {
                        notificationInfo = "commented on:"
                        singleImage.image = UIImage(named: "icon-notifications-comment")
                        cell.message.text = message
                        cell.message.lineBreakMode = .ByWordWrapping
                        cell.message.numberOfLines = 0
                    }
                }
                
            }
            
            cell.fullName.text = fullName
            cell.eventTipe.text = notificationInfo
            cell.iconNotifications.image = singleImage.image
            cell.clockIcon.image = UIImage(named: "icon-time")
            
            if  rowData["users"]?.count > 1 {
                let count = (rowData["users"]?.count)! - 1
                cell.avatar.image = UIImage(named: "avatar")
                cell.andLabel.text = "and"
                cell.oThersLabel.text = ("\(count) others")
                
            }
            else {
                cell.andLabel.text = " "
                cell.oThersLabel.text = " "
                
                if let img = imageCache[urlString] {
                    
                    cell.avatar.image = img

                }
                else {
                    
                    let request: NSURLRequest = NSURLRequest(URL: imgURL)
                    let session = NSURLSession.sharedSession()
                    
                    let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                        if error == nil {
                            let image = UIImage(data: data!)
                            let imageView: UIImageView = UIImageView(image: image)
                            
                            var layer: CALayer = CALayer()
                            layer = imageView.layer
                            layer.masksToBounds = true
                            layer.cornerRadius = CGFloat(50)
                            UIGraphicsBeginImageContext(imageView.bounds.size)
                            layer.renderInContext(UIGraphicsGetCurrentContext()!)
                           
                            let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            
                            
                            self.imageCache[urlString] = roundedImage
                            dispatch_async(dispatch_get_main_queue(), {
                                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as?CustomCell {
                                    
                                    cellToUpdate.avatar.image = roundedImage
                                }
                            })
                        }
                        
                    })
                    task.resume()
                }}
        }
        return cell
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = results
            self.notificationSort()
        })
        print("did recivee api results")
        
    }
    
    func   notificationSort() {
        for rowData in tableData {
            
            let   notificationType = rowData["notificationType"] as? String
            let notificationTypeText = rowData["notificationTypeText"] as? String
            
            if notificationType   == "Comment" && notificationTypeText  == "commented on your post" {
                
                tableData1.append(rowData as! NSDictionary)
            }
            else {
                
                if notificationType == "Message like" && notificationTypeText == "liked your post" {
                    
                    tableData1.append(rowData as! NSDictionary)
                }
                else {
                    if notificationType   == "Comment" && notificationTypeText  == "commented on" {
                        
                        tableData1.append(rowData as! NSDictionary)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }    
}
