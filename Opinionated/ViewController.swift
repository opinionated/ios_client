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
    struct articleData {
        var title:String
        var byline:String
        var image:String
    }
    var tableData = [articleData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Sets up the JSON to be read in Swift
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("articles", ofType: "json")!
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let error:NSError?
        let json = JSON(data: jsonData)
        
        for (_, subJson) in json["articles"] {
            tableData.append(articleData(title: subJson["title"].string!, byline: subJson["author"].string! + " | " + subJson["date"].string!, image: subJson["image"].string!))
        }
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.lblTitle!.text = tableData[indexPath.row].title
        cell.lblAuthor!.text = "by " + tableData[indexPath.row].byline
        
        requestImage(tableData[indexPath.row].image) { (image) -> Void in
            cell.lblImage.image = image
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("articleBody") as! articleBody
        navigationController?.pushViewController(destination, animated: true)
        
        performSegueWithIdentifier("articleSegue", sender: self)

        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "articleSegue" {
            // Setup new view controller
        }
    }
    
    func requestImage(url: String, success: (UIImage?) -> Void) {
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    
    func requestURL(url: String, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil) {
        NSURLConnection.sendAsynchronousRequest(
            NSURLRequest(URL: NSURL (string: url)!),
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { response, data, err in
                if let e = err {
                    error?(e)
                } else {
                    success(data)
                }
        })
    }
    
    
}