//
//  MasterViewControllerDataSource.swift
//  FlickerTest
//

import UIKit

// MARK: MasterViewControllerTableDataSource

@objc class MasterViewControllerTableDataSource: NSObject, UITableViewDataSource {
    var flickerObjects = [FlickerObject]()

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flickerObjects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell: MasterViewControllerTableViewCell = (tableView.dequeueReusableCellWithIdentifier("MasterViewControllerTableViewCell") as? MasterViewControllerTableViewCell)!

        cell.setUpCellWithObject(flickerObjects[indexPath.row])

        return cell
    }
    
}