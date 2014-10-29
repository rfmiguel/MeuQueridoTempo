//
//  WebService.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class WebService: NSObject {
    
    
    func getLocal(local:String){
    
        let url:NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/find?q=".stringByAppendingString(local).stringByAppendingString("&units=metric&LANG=pt") )
    
        let request:NSURLRequest = NSURLRequest(URL: url )

        var error = NSErrorPointer()
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: error) as Dictionary<String, AnyObject>
        var datastring:String = NSString(data: data!, encoding: NSUTF8StringEncoding)
        println(datastring)
    }
}
