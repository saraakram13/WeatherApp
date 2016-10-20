//
//  WeatherServer.swift
//  Weather
//
//  Created by sara akram on 8/25/16.
//  Copyright © 2016 sara akram. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct WeatherServer {
    
   
   
    
    
    static func weatherRequestCall(forCityName cityName: String = "San Francisco", completionHandler: (response: JSON) -> Void){
        
       
        let searchText = cityName.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(searchText),us&APPID=\(gApiKey)"
        
        print(urlString)

        Alamofire.request(.GET, urlString)
            .validate()
            .responseJSON(completionHandler: { (response) in
               
                print (response)
                
                if let value = response.result.value {
                    let jsonResponse = JSON(value)
                    completionHandler(response: jsonResponse)
                }
                
                
            })
        
    
    }
    
    
   

    
}
