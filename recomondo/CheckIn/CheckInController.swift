//
//  CheckInController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 23/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CheckInController: UICollectionViewController , UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, UISearchBarDelegate{
    
    //use lazy var to allow access to self
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
        
        //capture what's being typed in the search bar
        sb.delegate = self
        
        return sb
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        //TODO run a map search with the contents of the search bar
        //then reload the collection
        
        //TODO Put in a pause so we don't get all the results for every key pressed
        if searchText.isEmpty {
           return
        } else {
            //search venues that match the string
            fetchVenues(venueType: searchText.lowercased())}
    }
    
    
    let cellId = "cellId"
   // let headerId = "headerId"
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation(latitude: 52.36690669, longitude: 4.86892491)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load check in controller")
        locationManager.delegate = self
        setupCoreLocation() //initialise the location services
        
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
       
        collectionView?.register(VenueSearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        
        DispatchQueue.main.async {
            for venueType in ["De Hallen"] {
                self.fetchVenues(venueType:venueType)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false //make search bar reappear if we skip back and forth
    }


//somewhere to store the venues on the fly
var venues = [Venue]()
var mapItems = [MapItem]()

//create a search request
fileprivate func fetchVenues(venueType: String) {
    let request = MKLocalSearch.Request()
    
    //set the region of this request to 100m from user's location
    request.region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 25, longitudinalMeters: 25);
    request.naturalLanguageQuery = venueType
    //need a mapview region here?
    //for each item in our string, run a search and append venues into our array
    
    let search = MKLocalSearch(request: request)
    search.start { (response, error) in
        if error == nil {
            if let response = response{
                for mapItem in response.mapItems{
                    //let placemark = mapItem.placemark
                    print(mapItem)
                    print(mapItem.placemark)
                    var currentPlacemark = mapItem.placemark
                    
                    let venue = Venue(locationid: "123",
                                      dictionary: ["name" : mapItem.name,
                                                   "address":  "street address",//"123 big street amsterdam",
                                                    "distance":"123yd",
                                                   "latitude":"123",
                                                   "longitude":"123",
                                                   "isCurrentLocation":"false"])
                    //only load items < 100m away
                    self.venues.append(venue)
                }
            }
           }
       self.collectionView?.reloadData()
       }
}
    
    //MARK: - Delegates
    //MARK: location manager delegates
    func setupCoreLocation(){
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            enableLocationServices()
        default:
            break
        }
    }
    
    func enableLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy =  kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
    }
    
    //LocationManager delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("DEBUG*** Authorized")
        case .denied, .restricted:
            print("DEBUG*** not auth")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //we onlycare about the LAST element in this array - that's the most recent location captured by mapkit
        let location = locations.last!
        //coordinate2D = location.coordinate
        //let displayString = "\(location.timestamp)  Coordainate: \(coordinate2D)  Alt \(location.altitude) metres"
        print("Location is: ",  location)
        
        ///updateMapRegion(rangeSpan: 200)
        //let pizzaPin = PizzaAnnotation(coordinate: coordinate2D, title: displayString, subtitle: "")
        //mapView.addAnnotation(pizzaPin)
    }
    
    
    //MARK: collection delegates
    /*@objc func handleNext()
    {
        print("handling next")
        //push the sharePhoto controller onto the stack
        let vistVenueController = VisitVenueController()
        vistVenueController.selectedVenue = venue
        
        navigationController?.pushViewController(vistVenueController, animated: true)
    }*/
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()  //hide the keyboard :S when we show the profile view
        let venue = venues[indexPath.item]

        let vistVenueController = VisitVenueController()
        vistVenueController.selectedVenue = venue
        
        navigationController?.pushViewController(vistVenueController, animated: true)
        /*
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            searchBar.isHidden = true
            searchBar.resignFirstResponder()  //hide the keyboard :S when we show the profile view
            let user = filteredUsers[indexPath.item]
            print(user.username)
            
            let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
            userProfileController.userId = user.uid
            navigationController?.pushViewController(userProfileController, animated: true)
        }
        */
        
        
    }
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("*** Loaded venues: ***", venues.count)
        return venues.count
    }
    
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VenueSearchCell
        
        cell.venue = venues[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
    
    
    
    
}




// get local points of interest in a list
// allow user to select one
// if location they are at does not exist in maps
//      allow them to create it  ?
// take user to 'checkin / add visit'
// add this to their 'post' history

