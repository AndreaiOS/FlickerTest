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

    func deserializeObjects(jsonString: NSString) {
        var jsonDictionary: [String:AnyObject]
        var items: [[String:AnyObject]]

        jsonDictionary = convertStringToDictionary(jsonString as String)!
        items = (jsonDictionary["items"] as? [[String:AnyObject]])!

        self.dictionaryToObject(items)
    }

    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName("ErrorNotification", object: nil)

            }
        }
        return nil
    }

    func dictionaryToObject(JSONDictionary: [[String:AnyObject]]) {
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
