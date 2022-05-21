//
//  FeedTableViewCell.swift
//  discountTest
//
//  Created by michal packter on 20/05/2022.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUI(feedObj:AnyObject){

        textLabel?.backgroundColor = UIColor.clear
        detailTextLabel?.backgroundColor = UIColor.clear
        textLabel?.text = feedObj.object(forKey: "title") as? String
        textLabel?.textColor = UIColor.white
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        detailTextLabel?.text = feedObj.object(forKey: "pubDate") as? String
        detailTextLabel?.textColor = UIColor.white
    }

}
