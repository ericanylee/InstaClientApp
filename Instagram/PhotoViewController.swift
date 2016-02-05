//
//  ViewController.swift
//  Instagram
//
//  Created by Erica Lee on 1/28/16.
//  Copyright © 2016 Erica Lee, Yuting Zhang, Nuraini Aguse. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func tapImageGesture(sender: UITapGestureRecognizer) {
    performSegueWithIdentifier("performSegueFullImage", sender: self)
    }
    
    var media: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Do any additional setup after loading the view, typically from a nib.
        networkRequest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let media = media{
            return media.count
        }
        else{
            return 0
        }
    }
    
    func networkRequest(){
   
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.media = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                            
                    }
                }
        });
        
        task.resume()
        
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl){
        networkRequest()
        refreshControl.endRefreshing()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //reuse any available cell
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoViewCell
        let photo = media![indexPath.row]
        let imageDict = photo["images"] as! NSDictionary
        let image = imageDict["standard_resolution"] as! NSDictionary
        let url = NSURL(string: image["url"] as! String)
        cell.photo.setImageWithURL(url!)
        
        return cell
    }
    
}

