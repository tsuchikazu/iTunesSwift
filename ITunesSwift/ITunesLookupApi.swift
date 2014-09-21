//
//  ITunesLookupApi.swift
//  ITunesSwift
//
//  Created by 土屋 和良 on 2014/09/21.
//  Copyright (c) 2014年 tsuchikazu. All rights reserved.
//

import Foundation
import Alamofire

public class ITunesLookupApi {
    let url = "https://itunes.apple.com/lookup"
    
    var idName: String
    var id: Int
    
    public init(idName: String, id: Int) {
        self.idName = idName
        self.id = id
    }
    
    public func request(completionHandler: (String?, NSError?) -> Void) -> Void {
        Alamofire.request(.GET, self.buildUrl())
            .responseString { (request, response, str, error) -> Void in
                completionHandler(str, error)
        }
    }
    
    internal func buildUrl() -> String {
        var queryString: String = "?" + idName + "=" + String(id)
        
        return self.url + queryString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
}
