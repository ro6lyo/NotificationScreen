//
//  CustomCell.swift
//  NotificationScreen
//
//  Created by Mehmed Kadir on 10/01/15.
//  Copyright © 2015 Mehmed Kadir. All rights reserved.
//

import UIKit
import Foundation

class CustomCell: UITableViewCell {
    
    
    var avatar = UIImageView()
    var fullName = UILabel()
    var iconNotifications = UIImageView()
    var eventTipe = UILabel()
    var message = UILabel()
    var andLabel = UILabel()
    var oThersLabel = UILabel()
    
    
    
    var clockIcon = UIImageView()
    var clockInterval = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        andLabel.font = UIFont(name: "Lato-Bold", size: 15)
        oThersLabel.font = UIFont(name: "Lato-Bold", size: 15)
        fullName.font = UIFont(name: "Lato-Bold", size: 15)
        eventTipe.font = UIFont(name: "Lato-Regular", size: 15)
        message.font = UIFont(name: "HelveticaNeueLTStd-ThEx", size: 15)
        clockInterval.font = UIFont(name: "Lato-Regular", size: 14)
        
        
        clockInterval.textColor = UIColor(red:124.0/255.0,
            green:126.0/255.0,
            blue:136.0/255.0,
            alpha:1.0)
        
        andLabel.textColor = UIColor(red:124.0/255.0,
            green:126.0/255.0,
            blue:136.0/255.0,
            alpha:1.0)
        
        
        fullName.textColor = UIColor(red:17.0/255.0,
            green:107.0/255.0,
            blue:201.0/255.0,
            alpha:1.0)
        
        oThersLabel.textColor = UIColor(red:17.0/255.0,
            green:107.0/255.0,
            blue:201.0/255.0,
            alpha:1.0)
        
        eventTipe.textColor = UIColor(red:25.0/255.0,
            green:136.0/255.0,
            blue:173.0/255.0,
            alpha:1.0)
        
        
        
        
        message.translatesAutoresizingMaskIntoConstraints = false
        fullName.translatesAutoresizingMaskIntoConstraints = false
        eventTipe.translatesAutoresizingMaskIntoConstraints = false
        avatar.translatesAutoresizingMaskIntoConstraints = false
        iconNotifications.translatesAutoresizingMaskIntoConstraints = false
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        clockInterval.translatesAutoresizingMaskIntoConstraints = false
        oThersLabel.translatesAutoresizingMaskIntoConstraints = false
        andLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.contentView.addSubview(message)
        self.contentView.addSubview(fullName)
        self.contentView.addSubview(eventTipe)
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(iconNotifications)
        self.contentView.addSubview(clockIcon)
        self.contentView.addSubview(clockInterval)
        self.contentView.addSubview(oThersLabel)
        self.contentView.addSubview(andLabel)
        
        let viewsDict = [
            "avatar" : avatar,
            "fullname" : fullName,   // free
            "message" : message,       // susudrjanie
            "eventTipe" : eventTipe,
            "iconNotifications" : iconNotifications,
            "clockIcon" : clockIcon,
            "clockInterval" : clockInterval,
            "others" : oThersLabel,
            "and" : andLabel,
            
            
        ]
        
        
        var widthConstraint = avatar.widthAnchor.constraintEqualToAnchor(nil, constant: 50)
        var heightConstraint = avatar.heightAnchor.constraintEqualToAnchor(nil, constant: 50)
        NSLayoutConstraint.activateConstraints([ widthConstraint, heightConstraint])
        
        
        widthConstraint = iconNotifications.widthAnchor.constraintEqualToAnchor(nil, constant: 20)
        heightConstraint = iconNotifications.heightAnchor.constraintEqualToAnchor(nil, constant: 20)
        NSLayoutConstraint.activateConstraints([ widthConstraint, heightConstraint])
        
        widthConstraint = clockIcon.widthAnchor.constraintEqualToAnchor(nil, constant: 20)
        heightConstraint = clockIcon.heightAnchor.constraintEqualToAnchor(nil, constant: 20)
        NSLayoutConstraint.activateConstraints([ widthConstraint, heightConstraint])
        
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[avatar]-[fullname][and][others]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[avatar]-[iconNotifications][eventTipe]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[avatar]-[message]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[clockIcon][clockInterval]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[clockInterval]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[clockIcon]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[fullname][eventTipe]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[fullname][iconNotifications]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[and][iconNotifications]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[others][iconNotifications][message]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[avatar]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}