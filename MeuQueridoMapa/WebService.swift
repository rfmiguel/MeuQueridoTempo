//
//  WebService.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class WebService: NSObject {
    
    var clima:Array<Dictionary<String, AnyObject>>? = nil
    var _pathWsGoogle:String = "http://maps.googleapis.com/maps/api/geocode/json?latlng="
    
    
    func getLocal(local:String) -> Array<Dictionary<String, AnyObject>>
    {
        
        println()
        
//        let localformat = local.stringByAddingPercentEscapesUsingEncoding(encoding:)
        let newLocal:String = local.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        let strUrl:String = "http://api.openweathermap.org/data/2.5/find?q=".stringByAppendingString(newLocal).stringByAppendingString("&units=metric&LANG=pt")
        let url:NSURL = NSURL(string: strUrl)
        println(strUrl)

        let request:NSURLRequest = NSURLRequest(URL: url )

        
        var error = NSErrorPointer()
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: error) as Dictionary<String, AnyObject>
        self.clima = json["list"]! as? Array<Dictionary<String, AnyObject>>
        
        return self.clima!
        
    }
    
    func getState(lat:String,long:String) -> String
    {
        
        let url:NSURL = NSURL(string: _pathWsGoogle.stringByAppendingString(lat).stringByAppendingString(",").stringByAppendingString(long).stringByAppendingString("&sensor=true_or_false") )
        let request:NSURLRequest = NSURLRequest(URL: url )
        
        
        
        return ""
    }
    
}
