//
//  ViewController.swift
//  GoogleMapsAppSwift
//
//  Created by Никита Мошенцев on 27.11.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    private var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        mapView.delegate = self
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    func configureMap(coordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func addMarker(withCoordinate coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else { return }
        print(coordinate)
        addMarker(withCoordinate: coordinate)
        configureMap(coordinate: coordinate)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
