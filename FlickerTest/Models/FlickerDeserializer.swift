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
        var jsonDictionary: [String:AnyObject]
        var items: [[String:AnyObject]]

        //Converts data to String to remove a sometimes wrong escape sequence
        var dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        dataString = dataString?.stringByReplacingOccurrencesOfString("\\\'", withString: "")

        jsonDictionary = convertStringToDictionary(dataString! as String)!
        items = (jsonDictionary["items"] as? [[String:AnyObject]])!

        self.dictionaryToObject(items)
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
