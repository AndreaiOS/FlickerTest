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
        let jsonString = self.convertDataToString(data)
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
                NSNotificationCenter.defaultCenter().postNotificationName("ErrorNotification", object: nil)
            }
        }
        return nil
    }

    func dictionaryToObject(JSONDictionary: [[String:AnyObject]]) {
        flickerObjects.removeAll()

        for object in JSONDictionary {
            let singleObject: FlickerObject = FlickerObject()
            singleObject.title = (object["title"] as? String)!
            singleObject.mediaString = (object["media"]!["m"] as? String)!
            singleObject.dateTaken = (object["date_taken"] as? String)!

            flickerObjects.append(singleObject)
        }

        self.delegate!.objectDeserialized(flickerObjects)
    }
}
