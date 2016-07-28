//
//  MasterViewControllerTableDelegate.swift
//  FlickerTest
//


import UIKit

// MARK: MasterViewControllerTableDelegate

@objc class MasterViewControllerTableDelegate: NSObject, UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
}
