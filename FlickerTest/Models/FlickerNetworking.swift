//
//  FlickerNetworking.swift
//  FlickerTest
//


import Foundation

// MARK: FlickerNetworkingDelegate

protocol FlickerNetworkingDelegate {
    func dataDownloaded(jsonString: NSString)
    func dataDownloadedError(error: NSError)
}

// MARK: FlickerNetworking


class FlickerNetworking {
    let url: NSURL
    var delegate: FlickerNetworkingDelegate?

    init (urlString: String) {
        url = NSURL(string: urlString)!
    }

    /**
     Fetch data from Flickr API

     */
    func fetchData() {
        let session = NSURLSession.sharedSession()

        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData

        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in

            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                self.delegate!.dataDownloadedError(error!)
                return
            }

            var dataString = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
            dataString = dataString?.stringByReplacingOccurrencesOfString("\\\'", withString: "")

            self.delegate!.dataDownloaded(dataString!)
        }
        task.resume()
    }
}