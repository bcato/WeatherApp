//
//  ViewController.swift
//  Stormy
//
//  Created by Brandon Cato on 1/23/15.
//  Copyright (c) 2015 BrandonCato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let apiKey = "2fea654da11f5cdac51abb5fef844cfb"
    private let locationPoints = "37.8267/-122.423"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let encodedPoints = locationPoints.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let forecastURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/37.8267,-122.423", relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in

            if (error == nil) {
                let dataObject = NSData(contentsOfURL: location)!
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                
                println(currentWeather.currentTime!)
                
            }
            
            
        })
        
        
            downloadTask.resume()
    }

}

