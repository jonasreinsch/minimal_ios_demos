//
//  ViewController.swift
//  OCRMSOxfordDemo
//
//  Created by Jonas Reinsch on 13.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.

//  TODO:
//  - progress bar
//  - Later the flow should be:
//    1. upload to server
//    2. provide url
//    3. identification throgh UUID
//  - Image Resizing: http://nshipster.com/image-resizing/
//

func doesStringContainNumber(_string : String) -> Bool {
    let numberRegEx  = ".*[0-9]+.*"
    let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    let containsNumber = testCase.evaluateWithObject(_string)
    
    return containsNumber
}

import UIKit
import CoreLocation

// matching email addresses
// http://stackoverflow.com/a/17721692

// http://nshipster.com/nsdatadetector/
func applyDataDetectors(s:String, textCheckingTypes:NSTextCheckingType) {
//    let types: NSTextCheckingType =
    let detector = try? NSDataDetector(types: textCheckingTypes.rawValue)
    detector?.enumerateMatchesInString(s, options: [], range: NSMakeRange(0, (s as NSString).length)) { (result, flags, _) in
        
        guard let result = result else {
            return
        }
        
        print("\(s):, \(result)")
        
        if result.resultType == .Address {
            print(result.addressComponents)
        }
    }
}




import UIKit

let API_KEY = "54b15f6abf484592a2f9e4e437d9e578"

private extension Selector {
    static let tappedView = #selector(ViewController.tappedView)
}

func loadImage(imageName:String) -> UIImage {
    guard let image = UIImage(named: imageName) else {
        fatalError("could not load image named \(imageName)")
    }
    return image
}


let userDefaultsApiKey = "__USER_DEFAULTS_API_KEY__"
let images = [
    "test_image_small.png",
    "bc1.jpg",
    "bc2.jpg",
    "bc3.jpg",
    "bc4.jpg",
    ].map { loadImage($0) }
var imageIndex = 0
var image = images[imageIndex]

class ViewController: UIViewController {
    let imageView = UIImageView(image: image)
    
    func tappedView() {
        imageIndex = (imageIndex + 1) % images.count
        image = images[imageIndex]
        imageView.image = image
        makeOcrRequest(API_KEY, image: image, handler:{s in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.googleGeocoding(s)
            }
        
        })
    }
    
    func makeOcrRequest(apiKey:String, image:UIImage, handler: (s:String) -> ()) {
        
        guard let url = NSURL(string: "https://api.projectoxford.ai/vision/v1.0/ocr?language=unk&detectOrientation=true") else {
            fatalError("url seems to be invalid")
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)!

        let uploadTask = session.uploadTaskWithRequest(request, fromData: imageData) {
            data, response, error in
            
            do {
                guard let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] else {
                    print("error parsing toplevel JSON dict")
                    return
                }
                
//                print(dict)
                
                guard let regions = dict["regions"] as? [[String:AnyObject]] else {
                    print("error extracting regions (array of dictionaries) from JSON")
                    return
                }
//                print(regions)
                
                var lineStrings:[String] = []
                
                for region in regions {
                    guard let lines = region["lines"] as? [[String:AnyObject]] else {
                        print("error extracting lines (array of dictionaries) from region")
                        return
                    }
                    

                    for line in lines {
                        var wordsInLine:[String] = []
                        guard let words = line["words"] as? [[String:AnyObject]] else {
                            print("error extracting words (array of dictionaries from line")
                            return
                        }
                        
                        for word in words {
                            guard let text = word["text"] as? String else {
                                print("error extracting text attribute of word object")
                                return
                            }
                            
                            wordsInLine.append(text)
//                            print(text, terminator: " ")
                        }
                        print("")
                        lineStrings.append(wordsInLine.joinWithSeparator(" "))
                    }
                }
                
//                print(lineStrings)
                for lineString in lineStrings {
//                    print(lineString)
//                    applyDataDetectors(lineString, textCheckingTypes: [.Link, .PhoneNumber])
                }
//                applyDataDetectors(lineStrings.joinWithSeparator("\n"), textCheckingTypes: [.Address])
                var linesWithDigits:[String] = []
                print(lineStrings)
                for lineString in lineStrings {
                    // TODO: nur an wortgrenzen
                    if lineString.lowercaseString.containsString("tel.") {
                        continue
                    }
                    if lineString.lowercaseString.containsString("phon") {
                        continue
                    }
                    if lineString.lowercaseString.containsString("phone") {
                        continue
                    }
                    if lineString.lowercaseString.containsString("mobil") {
                        continue
                    }
                    if lineString.lowercaseString.containsString("fax") {
                        continue
                    }
                    
                    
                    if doesStringContainNumber(lineString) {
                        linesWithDigits.append(lineString)
                    }
                }
                
                handler(s: linesWithDigits.joinWithSeparator(" -- "))
            } catch {
                print("json error: \(error)")
            }
        }
        
        uploadTask.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tgr = UITapGestureRecognizer(target: self, action: .tappedView)
        view.addGestureRecognizer(tgr)
        
        configureAPIKeyPrompt()
        
        imageView.contentMode = .ScaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    }

    var alertController:UIAlertController?
    
    func configureAPIKeyPrompt() {
        alertController = UIAlertController(title: "Enter API Key",
            message: "Please enter the API Key. Press save, then restart app.",
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "API Key"
        })
        
        let action = UIAlertAction(title: "Save",
            style: UIAlertActionStyle.Default,
            handler: {
                (paramAction:UIAlertAction!) in
                if let textFields = self.alertController?.textFields {
                    let theTextFields = textFields as [UITextField]
                    let enteredText = theTextFields[0].text!
                    NSUserDefaults.standardUserDefaults().setValue(enteredText, forKey: userDefaultsApiKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            })
        
        alertController?.addAction(action)
        
        let cancelItem = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController?.addAction(cancelItem)
    }
    
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                if placemark?.areasOfInterest?.count > 0 {
                    let areaOfInterest = placemark!.areasOfInterest![0]
                    print(areaOfInterest)
                } else {
                    print("No area of interest found.")
                }
            }
        })
    }
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apiKey = "__INSERT_API_KEY__"

    func escape(s:String) -> String {
        return s.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())!
    }
    
    func googleGeocoding(s: String) {
        print(s)
        let urlString = "\(baseUrl)address=\(escape(s))&key=\(escape(apiKey))"
        // TODO add guard or use makeURL
        let url = NSURL(string: urlString)!
        print(url)
        let data = NSData(contentsOfURL: url)
        
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        guard let results = json["results"] as? [AnyObject] else {
            print("results key not found")
            return
        }
        
        if results.count == 0 {
            print("zero results")
            return
        }
        
        // we are only interested in the first result here
        // TODO: think about if it makes sense to use more than one
        //       result
        let result = results[0]
        
        guard let geometry = result["geometry"] as? [String:AnyObject] else {
            print("geometry key not found")
            return
        }
        
        guard let location = geometry["location"] as? [String:AnyObject] else {
            print("location key not found")
            return
        }

        guard let latitude = location["lat"] as? Float,
              let longitude = location["lng"] as? Float
        else {
            print("lat/long keys not found")
            return
        }
        
        guard let addressComponents = result["address_components"] as? [[String:AnyObject]] else {
            print("address_components key not found")
            return
        }
        
        var zip:String = ""
        var city:String = ""
        var state:String = ""
        var country:String = ""
        var route:String = ""
        var street:String = ""
        var streetNumber:String = ""
        
        
        for addressComponent in addressComponents {
            guard let types = addressComponent["types"] as? [String] else {
                print("no types in this addressComponent")
                continue
            }
            guard let longName = addressComponent["long_name"] as? String else {
                print("no long_name key in this addressComponent")
                continue
            }
            if types.contains("country") {
                country = longName
            }
            if types.contains("administrative_area_level_1") {
                state = longName
            }
//            if types.contains("administrative_area_level_2") {
//               print(longName)
//            }
            if types.contains("locality") {
                city = longName
            }
            if types.contains("route") {
                street = longName
            }
            if types.contains("street_number") {
                streetNumber = longName
            }
        }
        
        print("country: \(country)")
        print("state: \(state)")
        print("city: \(city)")
        print("street: \(street)")
        print("streetNumber: \(streetNumber)")
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
//        forwardGeocoding("1 Infinite Loop")

//        let s = "Jürgen Fischer Mayflower Capital Südbaden AG Schnewlinstraße 6 D - 79098 Freiburg"

        //let s = "Berner Str 23 79108 Freiburg"
        let s = "Schnewlinstrafğe 6 -- D - 79098 Freiburg"
        googleGeocoding(s)
        
        
//        applyDataDetectors(s, textCheckingTypes: [.Address])
        
        
        return;
        

        
        

        
//        makeOcrRequest(API_KEY, image: image)
        return
        
        
        if let apiKey = NSUserDefaults.standardUserDefaults().stringForKey(userDefaultsApiKey) {
//            makeOcrRequest(apiKey, image: image)
        } else {
            self.presentViewController(alertController!,
                animated: true,
                completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:NSURLSessionDataDelegate {
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print(Double(totalBytesSent)/Double(totalBytesExpectedToSend))
    }
}

