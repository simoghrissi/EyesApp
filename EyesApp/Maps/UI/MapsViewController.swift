//
//  MapsViewController.swift
//  EyesApp
//
//  Created by simo on 10/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}
class MapsViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,MKMapViewDelegate,HandleMapSearch {
   
    @IBOutlet weak var map: MKMapView!
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    let manager = CLLocationManager()
    var selectedPin: MKPlacemark?

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        map.delegate = self
        searchPoi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchPoi(){
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        searchController = UISearchController(searchResultsController: locationSearchTable)
        searchController.searchResultsUpdater = locationSearchTable
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = map
        locationSearchTable.handleMapSearchDelegate = self
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        
        self.map.showsUserLocation = true
    }
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        map.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        map.setRegion(region, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        
        
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "defaultImage"), for: UIControlState())
        button.addTarget(self, action: #selector(MapsViewController.presentCollectionImageView), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        
        return pinView
    }
    func presentCollectionImageView(){
        
        let storyboard = UIStoryboard(name: "CollectionPoi", bundle: nil)
        let imageCollectionVc = storyboard.instantiateViewController(withIdentifier: "ImageCollectionView")as? ImagesCollectionViewController
        self.navigationController?.pushViewController(imageCollectionVc!, animated: true)
    }
    func getDirections(){
    
           // DBManager.putPoiInData(name: "simo", type: "waaw", otherInf: "bouuuh")
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
