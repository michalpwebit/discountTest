//
//  SportAndEntertainmentViewController.swift
//  discountTest
//
//  Created by michal packter on 21/05/2022.
//

import UIKit

class SportAndEntertainmentViewController: UITableViewController,XMLParserDelegate {
    var sportFeed : NSArray = []
    var entertainmentFeed : NSArray = []
    var sportUrl: URL!
    var entUrl : URL!
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        loadData()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadData), userInfo: nil, repeats: true);
        
    }
    @objc func loadData() {
        sportUrl = URL(string: "http://rss.cnn.com/rss/edition_sport.rss")!
        loadSportRss(sportUrl);
        entUrl = URL(string: "http://rss.cnn.com/rss/edition_entertainment.rss")!
        loadEntRss(entUrl);
        
        
    }
    func loadSportRss(_ data: URL) {
        let sportParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        if sportParser.feeds.count > sportFeed.count{
            sportFeed = sportParser.feeds
            
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    func loadEntRss(_ data: URL) {
        let entParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        if entParser.feeds.count > entertainmentFeed.count{
            
            entertainmentFeed = entParser.feeds
            tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    func seveData(objcToSave:AnyObject){
        let userDefaults = UserDefaults.standard
        
        userDefaults.set((objcToSave.object(forKey: "link") as! String), forKey:"link" )
        userDefaults.set((objcToSave.object(forKey: "title") as! String), forKey:"title" )
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shoeSportAndEntWeb" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            var selectedFURL = String()
            if indexPath.section == 0{
                selectedFURL = (sportFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
                seveData(objcToSave:sportFeed[indexPath.row] as AnyObject)
                
            }else{
                selectedFURL = (entertainmentFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
                seveData(objcToSave:entertainmentFeed[indexPath.row] as AnyObject)
                
            }
            let vc: ShowItemViewController = segue.destination as! ShowItemViewController
            vc.selectedItemURL = selectedFURL as String
        }
    }
    
    // MARK: - Table view data source.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return sportFeed.count
        }
        else if section == 1{
            return entertainmentFeed.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        if indexPath.section == 0{
            cell.setUI(feedObj: sportFeed.object(at: indexPath.row) as AnyObject)
       
        }else{
            cell.setUI(feedObj: entertainmentFeed.object(at: indexPath.row) as AnyObject)
            
        }
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0, green: 255/255, blue: 255/255, alpha: 1.0)
          }else{
            cell.backgroundColor = UIColor(red: 0, green: 255/255, blue: 255/255, alpha: 0.5) // set your default color
          }

        return cell
    }
    
    
    
    
}
