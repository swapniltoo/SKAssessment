//
//  GlobalMethod.swift
//  Assessment
//
//  Created by Apple on 20/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


private let SharedInstance = GlobalMethod()

enum Endpoint : String {
    
    case mostviewed                   = "/svc/mostpopular/v2/mostviewed/all-sections/"
    case articleUrl                   = "2"
}
class GlobalMethod: NSObject {

    public let BaseApiPath:String = "http://api.nytimes.com"
    private let APIKey:String = "R9TObEtgfKGH6zHiM8gKUZpFcDOtaQav"
    
//    var requestManager = AFHTTPSessionManager()
    
    class var sharedInstance : GlobalMethod {
        return SharedInstance
    }

    override init() {
    }

    
    //MARK: viewsAPI
    
    func getPopulerViews(availableperiod:String, completionHandler:@escaping (_ result:Bool, _ responseObject:NSDictionary?) -> Void){
        let url = "\(BaseApiPath)\(Endpoint.mostviewed.rawValue)\(availableperiod).json?api-key=\(APIKey)"

        if let url = URL(string: url) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                 if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                    let json = jsonString.parseJSONString
                    completionHandler(true, json as? NSDictionary )
                 }
               }
            else
            {
                completionHandler(false, nil)
            }
           }.resume()
        }
    }
}


extension String
{
var parseJSONString: AnyObject?
{
    let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
    if let jsonData = data
    {
        // Will return an object or nil if JSON decoding fails
        do
        {
            let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
            if let jsonResult = message as? NSMutableArray {
                return jsonResult //Will return the json array output
            } else if let jsonResult = message as? NSMutableDictionary {
                return jsonResult //Will return the json dictionary output
            } else {
                return nil
            }
        }
        catch let error as NSError
        {
            print("An error occurred: \(error)")
            return nil
        }
    }
    else
    {
        // Lossless conversion of the string was not possible
        return nil
    }
}

}
