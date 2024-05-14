//
//  GeoDistanceCalculator.swift
//  Wallet for iPad
//
//  Created by Anand Upadhyay on 13/05/24.
//

import Foundation
////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
///  This routine calculates the distance between two points (given the      ///
///  latitude/longitude of those points). It is being used to calculate      ///
///  the distance between two location using GeoDataSource(TM)               ///
///  products.                                                               ///
///                                                                          ///
///  Definitions:                                                            ///
///    South latitudes are negative, east longitudes are positive            ///
///                                                                          ///
///  Passed to function:                                                     ///
///    lat1, lon1 = Latitude and Longitude of point 1 (in decimal degrees)   ///
///    lat2, lon2 = Latitude and Longitude of point 2 (in decimal degrees)   ///
///    unit = the unit you desire for results                                ///
///           where: 'M' is statute miles (default)                          ///
///                  'K' is kilometers                                       ///
///                  'N' is nautical miles                                   ///
///                                                                          ///
///  Worldwide cities and other features databases with latitude longitude   ///
///  are available at https://www.geodatasource.com                          ///
///                                                                          ///
///  For enquiries, please contact sales@geodatasource.com                   ///
///                                                                          ///
///  Official Web site: https://www.geodatasource.com                        ///
///                                                                          ///
///  GeoDataSource.com (C) All Rights Reserved 2022                          ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
///  This function converts decimal degrees to radians              ///
///////////////////////////////////////////////////////////////////////


class TestGeo{
    func deg2rad(deg:Double) -> Double {
        return deg * Double.pi / 180
    }

    ///////////////////////////////////////////////////////////////////////
    ///  This function converts radians to decimal degrees              ///
    ///////////////////////////////////////////////////////////////////////
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / Double.pi
    }

    func distance(_ lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }
    
    init(){
        print(distance(Double(32.9697), lon1: Double(-96.80322), lat2: Double(29.46786), lon2: Double(-98.53506), unit: "M"), "Miles")
        print(distance(Double(32.9697), lon1: Double(-96.80322), lat2: Double(29.46786), lon2: Double(-98.53506), unit: "K"), "Kilometers")
        print(distance(Double(32.9697), lon1: Double(-96.80322), lat2: Double(29.46786), lon2: Double(-98.53506), unit: "N"), "Nautical Miles")
    }
}

