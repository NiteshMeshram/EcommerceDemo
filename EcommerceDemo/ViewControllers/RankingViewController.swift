//
//  RankingViewController.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/16/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation

import UIKit

class RankingViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var cellIdentifier = "rankCell"
    
    var rankingDataSource: [Rankings] = []
    
    var productDataSource: NSArray = []
    
    var productsAggregate:[[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("fetchAllRainking ===> \(DataManager.sharedInstance.fetchAllRainkingGroupby().count)")


//        rankingDataSource = (DataManager.sharedInstance.fetchAllRainking() as NSArray) as! [Rankings]
        
//        rankingDataSource = (Rankings)
        
        
        self.productsAggregate = DataManager.sharedInstance.aggregateProductsInContext()
        
        let nib = UINib.init(nibName: "RankingTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        
        rankingDataSource.forEach { ranking in
         

            print("\(String(describing: ranking.productRanking))")
            print("\(String(describing: ranking.rankingName))")
            print("\(String(describing: ranking.rankingTypeCount))")
        }
        
        
//        productDataSource =  rankingDataSource[0] as! NSArray
        
//        print("productDataSource.count =>> \(productDataSource.count)")
        
        
    }
    
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    // As long as `total` is the last case in our TableSection enum,
    // this method will always be dynamically correct no mater how many table sections we add or remove.
    func numberOfSections(in tableView: UITableView) -> Int {
//        return TableSection.total.rawValue
//        return rankingDataSource.count
        
        return (productsAggregate?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Using Swift's optional lookup we first check if there is a valid section of table.
        // Then we check that for the section there is data that goes with.
//        if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection] {
//            return movieData.count
//        }
        
//        productDataSource =  rankingDataSource[section] as! NSArray
//
//        print("productDataSource.count =>> \(productDataSource.count)")
        
        
        
//        return (rankingDataSource[section].productRanking?.count)!
        
        
        return productsAggregate![section])
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        // If we wanted to always show a section header regardless of whether or not there were rows in it,
//        // then uncomment this line below:
//        //return SectionHeaderHeight
//        // First check if there is a valid section of table.
//        // Then we check that for the section there is more than 1 row.
//        if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection], movieData.count > 0 {
//            return SectionHeaderHeight
//        }
//        return 0
//    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let header = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RankingTableViewCell
        header.textLabel?.text = "My Header"
        header.textLabel?.textColor = UIColor.black
        header.contentView.backgroundColor = UIColor.blue
        return header
    }

}



//public protocol Groupable {
//    func sameGroupAs(otherPerson: Self) -> Bool
//}
//
//extension Rankings: Groupable {
//
//    func sameGroupAs(otherPerson: Rankings) -> Bool {
//        let f = self.name.characters.first
//        let s = otherPerson.name.characters.first
//
//        return f == s
//    }
//
//}






