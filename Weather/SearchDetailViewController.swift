//
//  SearchDetailViewController.swift
//  Weather
//
//  Created by sara akram on 8/29/16.
//  Copyright © 2016 sara akram. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    var searchResult : (cityName: String, temps: [Double])!
    
    @IBOutlet var cityLabel : UILabel!
    @IBOutlet var tempLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = " Location: \(searchResult.cityName)"
        tempLabel.text = "Temperature: \(searchResult.temps[0] - 273.15)℃"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
