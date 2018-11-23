//
//  ViewController.swift
//  lab231118
//
//  Created by Patrick Kainz and Patrick Papst on 23.11.18.
//  Copyright © 2018 Patrick Kainz and Patrick Papst. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        annotation.title = "FH Kapfenberg"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 47.453990, longitude: 15.331747)
        map.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        map.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //stolen from https://stackoverflow.com/questions/14760582/mkmapview-zoom-user-location-and-annotation
        let userPos = mapView.userLocation.coordinate
        let annotationPos = annotation.coordinate
        let userPoint = MKMapPoint(userPos);
        let annotationPoint = MKMapPoint(annotationPos)
        let userRect = MKMapRect(x: userPoint.x,y: userPoint.y,width: 0,height: 0)
        let annotationRect = MKMapRect(x: annotationPoint.x,y: annotationPoint.y,width: 0,height: 0)
        let unionRect = userRect.union(annotationRect)
        let fittingRect = mapView.mapRectThatFits(unionRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
        mapView.setVisibleMapRect(fittingRect, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { print("not enabled"); return }
        map.showsUserLocation = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

