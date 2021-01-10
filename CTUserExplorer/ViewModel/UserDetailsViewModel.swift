//
//  UserDetailsViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UserDetailsViewModel {
    var delegate: UserDetailsViewModelDelegate?
    var user: User!
    
    func viewLoaded(){
        self.delegate?.reloadUIElements()
    }
    
    func getFullAddress() -> String {
        guard let address = user.address else {
            return "No Address"
        }
        let fullAddress = [address.suite ?? "", address.street ?? "", address.city ?? "", address.zipcode ?? ""]
        return fullAddress.joined(separator: " ")
    }
    
    func openCoordinatesOnMap(){
        guard let latitudeString = user.address?.coordinates?.lat, let longitudeString = user.address?.coordinates?.long, let latitude = CLLocationDegrees(latitudeString), let longitude = CLLocationDegrees(longitudeString) else {
            return
        }
        
        let regionDistance:CLLocationDistance = 5000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Coordinate Location"
        mapItem.openInMaps(launchOptions: options)
    }
}

protocol UserDetailsViewModelDelegate {
    func reloadUIElements()
}
