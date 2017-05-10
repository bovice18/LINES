//
//  JSONRating.swift
//  LINES
//
//  Created by david crabtree on 4/26/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation

struct JSONRating {
    /*
    enum Name: String {
        case Chipotle, Bentleys, Potbelly
    }
    */
    
    let circleRating: String
    let lineRating: String
    let comments: String
    let Time: String
    //let name: Set<Name>
    let location: String
}
/*

extension JSONRating {
    init?(json: [Any]) {
        for case let object in json {
            
        // access individual object in array
            
            guard let dictionary = object as? [String: Any] else {
                return nil
            }
            
                guard let circleRating = dictionary["circleRating"] as? String,
                    let lineRating = dictionary["lineRating"] as? String,
                    let Time = dictionary["timeDate"] as? String,
                    let location = dictionary["locationName"] as? String,
                    let comments = dictionary["comments"] as? String
                    else {
                        return nil
                    }
                    
            
        self.circleRating = circleRating
        self.comments = comments
        self.Time = Time
        self.location = location
        self.lineRating = lineRating
            
    }
    }
}
*/
/*

extension JSONRating {
   
    
    
    static func ratings(completion: @escaping ([JSONRating]) -> Void) {
        
        let session: URLSession
    
    
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        let urlWithParams = scriptURL
        let myUrl = NSURL(string: urlWithParams);
        let request = NSMutableURLRequest(url: myUrl as! URL);
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in

            var chipotleRatings: [JSONRating] = []
            var bentleysRatings: [JSONRating] = []
            var ratings: [JSONRating] = []
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                for case let object in json! {
                    if let dictionary = object as? [String: Any] {
                       // if let name = dictionary["locationName"] as? String {
                           let  name = "S"
                            var FilterName = name
                            switch FilterName {
                                
                            case "Chipotle":
                                
                                chipotleRatings.append(object as! JSONRating)
                                
                            case "Bentley's":
                                
                                chipotleRatings.append(object as! JSONRating)
                                
                            default:
                                
                                ratings.append(object as! JSONRating)
                           // }
                        }
                    }
                }
            }
            
            completion(ratings)
            
        }
       // }).resume()
        
         task.resume()
}
}


       // URLSession.dataTask(with: request as URLRequest) { _,_,_ in

    // session.dataTask(url: scriptURL, completion: { (data, response, error) in



    /*
    //private let urlComponents: URLComponents
    private let session: URLSession
    
    

    static func ratings(matching query: String, completion: @escaping ([JSONRating]) -> Void) {
        
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        
        let
        

        session.shared.dataTask(url: scriptURL, completion: { (data, response, error) in
            var chipotleRatings: [JSONRating] = []
            var bentleysRatings: [JSONRating] = []
            var ratings: [JSONRating] = []
            
          if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                for case let object in json! {
                    if let dictionary = object as? [String: Any] {
                        if let name = dictionary["locationName"] as? String {
                            var FilterName = name
                            switch FilterRating {
                                
                            case "Chipotle":
                                
                            chipotleRatings.append(object)
                                
                            case "Bentley's":
                                
                            chipotleRatings.append(object)
                                
                            default:
                                
                                ratings.append(object)
                            }
                        }
                    }
                }
            }
            
            completion(ratings)
        
    }).resume()

}
}
    
   // static func restaurants(matching query: String, completion: ([Restaurant]) -> Void) {
        
    

       // var searchURLComponents = urlComponents
      //  searchURLComponents.path = "/search"
      //  searchURLComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        //let searchURL = searchURLComponents.url!
        
      /*
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        // Add one parameter
        let urlWithParams = scriptURL
        let myUrl = NSURL(string: urlWithParams);
        let request = NSMutableURLRequest(url: myUrl as! URL);
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
 let myUrl = NSURL(string: scriptURL);
 
 let request = NSMutableURLRequest(url: myUrl as! URL);
 
 request.httpMethod = "GET"
 
 URLSession.shared.dataTask(with: request as URLRequest) { Data,_,_ in
 
            */
 */
*/


