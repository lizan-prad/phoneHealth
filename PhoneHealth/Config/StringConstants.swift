//
//  StringConstants.swift
//  VenueFinder
//
//  Created by Lizan on 21/12/2021.
//

import Foundation

enum StringConstants {

    static let decodeError = "Decoding failed."
    static let controller = "ViewController"
    static let alertLocationAccess = "Please allow the locaiton usage to use the application"
    static let bundleVersionString = "CFBundleShortVersionString"
    static let appDescriptionString = "We find you the nearest 5 VENUES from your location"
    
    enum CoreDataContext {
        static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
    }
    
    enum UserDefaultsKey {
        static let appHasData = "ApplicationHasData"
    }

    enum CoreDataEntity {
        static let geoCodeEntity = "GeoPointEntity"
        static let resultEntity = "ResultEntity"
        static let geoLocationsEntity = "GeoLocationsEntity"
        static let venueEntity = "VenueEntity"
        static let categoryEntity = "CategoryEntity"
        static let addressEntity = "AddressEntity"
        static let geoPointEntity = "GeoPointEntity"
        static let iconEntity = "IconEntity"
    }

    enum TableViewCells {
        static let venueListCell = "VenueListTableViewCell"
    }
    
    enum CollectionViewCells {
        static let venueImageCell = "VenueImageCollectionViewCell"
    }
}

