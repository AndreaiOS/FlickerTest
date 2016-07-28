//
//  MasterViewController.swift
//  FlickerTest
//


import UIKit

// MARK: MasterViewController

class MasterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var delegate: MasterViewControllerTableDelegate = MasterViewControllerTableDelegate()
    var dataSource: MasterViewControllerTableDataSource = MasterViewControllerTableDataSource()

    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.delegate = delegate

        self.addObservers()
        self.setRefreshControl()
    }

    func setRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(MasterViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }

    func refresh(sender:AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadData",
                                                                  object: nil)
    }

    func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(MasterViewController.showError(_:)),
                                                         name:"ShowErrorNotification",
                                                         object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(MasterViewController.dataReady(_:)),
                                                         name:"DataReady",
                                                         object: nil)
    }

    // MARK: Notification Selectors

    func dataReady(notification: NSNotification) {
        dataSource.flickerObjects = (notification.object as? [FlickerObject])!
        dispatch_async(dispatch_get_main_queue(), {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        })
    }

    func showError(notification: NSNotification) {
        let alertController = UIAlertController(title: "Error",
                                                message: "A standard error alert",
                                                preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (action: UIAlertAction!) in

        }
        alertController.addAction(cancelAction)

        let OKAction = UIAlertAction(title: "Retry", style: .Default) {
            (action: UIAlertAction!) in
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadData",
                                                                      object: nil)
        }
        alertController.addAction(OKAction)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alertController, animated: true, completion:nil)
        })
    }
}
