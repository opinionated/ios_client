//
//  ViewController.swift
//  Opinionated
//
//  Created by Theodore Rice on 3/22/16.
//  Copyright (c) 2016 opinionated. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource {
    
    // Creates the array of articles that will be called for each individual cell
    // and creates the count of the articles, default to 0, which will decide
    // the amount of rows to create in the table view.
    var articleArray = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Sets up the JSON to be read in Swift
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("articles", ofType: "json")!
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let error:NSError?
        let json = JSON(data: jsonData)
        
        
        // Example json parse
//        for (_, subJson) in json["articles"] {
//            let title = subJson["title"].string;
//            articleArray.append(subJson["title"].string!)
//            let author = subJson["author"].string;
//            print(title! + " by " + author!);
//        }
        
        count = json["articles"].count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel!.text = articleArray[indexPath.item]
        return cell
    }
    
}