//
//  DetailViewController.swift
//  ITunesSwiftDemo
//
//  Created by 土屋 和良 on 2014/09/21.
//  Copyright (c) 2014年 tsuchikazu. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var detailJson: JSON? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("row")
        println(detailJson)
        if let count = detailJson?.length {
            return count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
        
        if let detailAttributes: [String:JSON] = detailJson?.asDictionary {
            var key : String = Array(detailAttributes.keys)[indexPath.row]
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = detailAttributes[key]?.toString()
        }
        
        return cell
    }

}