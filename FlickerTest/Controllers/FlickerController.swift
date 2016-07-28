//
//  FlickerController.swift
//  FlickerTest
//


import Foundation

// MARK: FlickerControllerDelegate

protocol FlickerControllerDelegate {
    func showError()
}

// MARK: FlickerController

class FlickerController {
    var urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&nojsoncallback=1"
    let networking: FlickerNetworking
    let deserializer: FlickerDeserializer
    var flickerObjects = [FlickerObject]()

    init () {
        deserializer = FlickerDeserializer.init()
        networking = FlickerNetworking.init(urlString: urlString)

        deserializer.delegate = self
        networking.delegate = self

        addObservers()

        reload()
    }

    func reload() {
        networking.fetchData()
    }

    func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FlickerController.showError(_:)),
                                                         name:"ErrorNotification",
                                                         object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(FlickerController.reloadNotification(_:)),
                                                         name:"ReloadData",
                                                         object: nil)
    }

    // MARK: Notification Selectors

    @objc func reloadNotification(notification: NSNotification) {
        reload()
    }


    @objc func showError(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("ShowErrorNotification",
                                                                  object: nil)
    }
}

// MARK: FlickerController-FlickerNetworkingDelegate

extension FlickerController: FlickerNetworkingDelegate {

    func dataDownloaded(data: NSData) {
        deserializer.deserializeObjects(data)
    }

    func dataDownloadedError(error: NSError) {
        NSNotificationCenter.defaultCenter().postNotificationName("ErrorNotification", object: nil)
    }
}

// MARK: FlickerController-FlickerDeserializerDelegate

extension FlickerController: FlickerDeserializerDelegate {

    func objectDeserialized(objects: [FlickerObject]) {
        flickerObjects = objects
        NSNotificationCenter.defaultCenter().postNotificationName("DataReady", object: flickerObjects)
    }
}
