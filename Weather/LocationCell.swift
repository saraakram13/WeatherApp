//
//  LocationCell.swift
//  Weather
//
//  Created by sara akram on 8/25/16.
//  Copyright © 2016 sara akram. All rights reserved.
//

import Foundation
import UIKit

protocol LocationTableDelegate {
    
    func cityTapped (cell: LocationCell)
    
}
class LocationCell: UITableViewCell {
    
    var delegate: LocationTableDelegate?
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
   
    
    
    
}
