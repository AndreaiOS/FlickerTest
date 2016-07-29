//
//  FlickerDeserializer.swift
//  FlickerTest
//


import Foundation

// MARK: FlickerDeserializerDelegate

protocol FlickerDeserializerDelegate {
    func objectDeserialized(objects: [FlickerObject])
}
// MARK: FlickerDeserializer

class FlickerDeserializer {

    var flickerObjects = [FlickerObject]()
    var delegate: FlickerDeserializerDelegate?

    func deserializeObjects(data: NSData) {
        let jsonString = convertDataToString(data)
        var jsonDictionary = convertStringToDictionary(jsonString)

        let items = (jsonDictionary!["items"] as? [[String:AnyObject]])!

        self.dictionaryToObject(items)
    }

    func convertDataToString(data: NSData) -> String {
        var dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        dataString = dataString?.stringByReplacingOccurrencesOfString("\\\'", withString: "")

        return (dataString! as String)
    }

    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch _ as NSError {
                NSNotificationCenter.defaultCenter().postNotificationName(StandardNotifications.ShowErrorNotification.rawValue, object: nil)
            }
        }
        return nil
    }

    func dictionaryToObject(JSONDictionary: [[String:AnyObject]]) {
        flickerObjects.removeAll()

        let flickerObjectsMapped: [FlickerObject] = JSONDictionary.map({
             FlickerObject(title: ($0["title"] as? String)!,
                     mediaString: ($0["media"]!["m"] as? String)!,
                       dateTaken: ($0["date_taken"] as? String)!
            )
            }
        )
        delegate!.objectDeserialized(flickerObjectsMapped)
    }
}
