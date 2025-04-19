//
//  LocationCity.swift
//
//  Created by Ivan Lo on 28/10/2020.
//

import UIKit

class LocationCity {
    
    var cityIndex = 0
    var cityCenterPoint = CGPoint(x: 0.00, y: 0.00)
    
    init(centerPoint:CGPoint,cityIndex:Int){
        self.cityCenterPoint = centerPoint
        self.cityIndex = cityIndex
    }
}
