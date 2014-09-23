//
//  MasterViewController.swift
//  ITunesSwiftDemo
//
//  Created by Kazuyoshi Tsuchiya on 2014/09/21.
//  Copyright (c) 2014 tsuchikazu. All rights reserved.
//

import UIKit
import ITunesSwift

class MasterViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultJson: JSON?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                var selectedRow = searchResultJson!["results"][indexPath.row]
                iTunesApi.lookup(selectedRow["trackId"].asInt!).request() { (result ,error) in
                    var resultJson: JSON = JSON.parse(result!)
                    var selectedRowJson: JSON = resultJson["results"][0]
                    (segue.destinationViewController as DetailViewController).detailJson = selectedRowJson
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = searchResultJson?["resultCount"].asInt {
            return count
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        if let result = searchResultJson?["results"][indexPath.row] as JSON? {
            cell.textLabel?.text = result["trackName"].asString
            cell.detailTextLabel?.text = result["artistName"].asString
            cell.imageView?.image = nil
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                if let artworkUrl = result["artworkUrl60"].asString {
                    let imageURL: NSURL   = NSURL.URLWithString(artworkUrl)
                    let image = UIImage(data: NSData(contentsOfURL: imageURL))
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.imageView?.image = image
                        cell.layoutSubviews()
                    }
                }
            }
        }
        
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar?.resignFirstResponder()
        
        iTunesApi.find(Media.Music).by(searchBar.text).request() { (result, error) in
            self.searchResultJson = JSON.parse(result!)
            self.tableView.reloadData()
        }
    }


}

