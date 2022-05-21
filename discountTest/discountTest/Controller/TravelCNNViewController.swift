//
//  TravelCNNViewController.swift
//  discountTest
//
//  Created by michal packter on 20/05/2022.
//

import UIKit


class TravelCNNViewController: UITableViewController, XMLParserDelegate {

    var myFeed : NSArray = []
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.dataSource = self
        self.tableView.delegate = self

        loadData()
    }

    func loadData() {
        url = URL(string: "http://rss.cnn.com/rss/edition_travel.rss")!
        loadRss(url);
    }

    func loadRss(_ data: URL) {
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        myFeed = myParser.feeds
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String

            let vc: ShowItemViewController = segue.destination as! ShowItemViewController
            vc.selectedItemURL = selectedFURL as String
            seveData(objcToSave:myFeed[indexPath.row] as AnyObject)
        }
    }
    func seveData(objcToSave:AnyObject){
        let userDefaults = UserDefaults.standard

        userDefaults.set((objcToSave.object(forKey: "link") as! String), forKey:"link" )
        userDefaults.set((objcToSave.object(forKey: "title") as! String), forKey:"title" )

        
    }

    // MARK: - Table view data source.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        cell.setUI(feedObj: myFeed.object(at: indexPath.row) as AnyObject)
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0, green: 255/255, blue: 0, alpha: 1.0)
          }else{
            cell.backgroundColor = UIColor(red: 0, green: 255/255, blue: 0, alpha: 0.5) 
          }

        return cell
    }
  


}
