//
//  ViewController.swift
//  hello-maps
//
//  Created by Macbook on 28/08/2018.
//  Copyright © 2018 Lodge Farm Apps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
	
	private let locationManager = CLLocationManager()
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
	self.mapView.delegate = self
		
	locationManager.delegate = self
	locationManager.requestWhenInUseAuthorization()
	locationManager.desiredAccuracy = kCLLocationAccuracyBest
	locationManager.distanceFilter = kCLDistanceFilterNone
	locationManager.startUpdatingLocation()
		
	self.mapView.showsUserLocation = true
	self.mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
	
	}
	
	@objc func mapTypeChanged(segmentedControl: UISegmentedControl) {
		
		switch(segmentedControl.selectedSegmentIndex) {
			
		case 0:
			self.mapView.mapType = .standard
		case 1:
			self.mapView.mapType = .satellite
		case 2:
			self.mapView.mapType = .hybrid
		default:
			self.mapView.mapType = .standard
			
		}
	}
	
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
		
		let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
		
		mapView.setRegion(region, animated: true)
	}
}

