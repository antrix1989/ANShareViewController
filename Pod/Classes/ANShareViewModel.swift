//
//  ANShareViewModel.swift
//  Antsquare
//
//  Created by Sergey Demchenko on 8/8/15.
//  Copyright (c) 2015 Antsquare Technologies Inc. All rights reserved.
//

import UIKit

class ANShareViewModel: NSObject
{
    var contentURL: NSURL!
    var title: String?
    var message: String?
    
    func messageBody() -> String!
    {
        var result = ""
        
        if let message = message, let url = contentURL.absoluteString {
            result = "\(message) \(url)"
        } else if let url = contentURL.absoluteString {
            result = "\(url)"
        }
        
        return result
    }
    
    func mailToUrl(subject: String, body: String) -> NSURL?
    {
        var components = NSURLComponents(string: "mailto:")
        components?.queryItems = [NSURLQueryItem(name: "subject", value: subject), NSURLQueryItem(name: "body", value: body)]
        return components?.URL
    }
}
