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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("articles", ofType: "json")!
            let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
            let error:NSError?
            let json = JSON(data: jsonData)
        
        for (_, subJson) in json["articles"] {
            if let title = subJson["title"].string {
                if let author = subJson["author"].string {
                    print(title + " by " + author)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var repositories = [String]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = repositories[indexPath.row]
        return cell
    }
    
}