//
//  mapViewController.swift
//  LINES
//
//  Created by david crabtree on 6/18/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var DillosCircle: Int?
    
    var McGraveysCircle: Int?
    
    var PussersCircle: Int?
    
    var AcmeCircle: Int?
    
    var MoesCircle: Int?
    
    var FedHouseCircle: Int?
    
    var JossCircle: Int?
    
    var AnnapolisIce: Int?
    
    var DockStreetCircle: Int?
    
    var CityDockCircle: Int?
    
    var IronRooserCircle: Int?
    
    var StormBrosCircle: Int?
    
    var StarbucksCircle: Int?
    
    let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
    
    func NewLoadData() {
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getDataNew.php"
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl as! URL);
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            
            if let dictionary = json as? [String: Any] {
                
                if let nestedDictionary = dictionary["Acme"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.AcmeCircle = Int(recent)!
                    }
                    
                }
                
                if let nestedDictionary = dictionary["McGarveys"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.McGraveysCircle = Int(recent)!
                    }
                    
                }
                
                
                if let nestedDictionary = dictionary["Armadillos"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.DillosCircle = Int(recent)!
                    }
                    
                }
                
                
                if let nestedDictionary = dictionary["Dock Street"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.DockStreetCircle = Int(recent)!
                    }
                }
                
                
                if let nestedDictionary = dictionary["Pussers"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.PussersCircle = Int(recent)!
                    }
                    
                }
                
                
                if let nestedDictionary = dictionary["Federal House"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.FedHouseCircle = Int(recent)!
                    }
                }
                //  self.sampleLocations()
                //  DispatchQueue.main.async() { self.tableView.reloadData() }
                
                DispatchQueue.main.async() {
                    
                    
                    switch UserDefaults.standard.integer(forKey: "locationSelected") {
                    case 0:
                        print("Annapolis")
                        self.addingSubtitle()
                        
                        self.addingSubtitle2()
                        
                        self.addingSubtitle3()
                        
                        self.addingSubtitle4()
                        
                        self.addingSubtitle5()
                        
                        self.addingSubtitle7()
                    case 1:
                        print("College Park")
                        self.addingSubtitleBentleys()
                    default:
                        print("no location selected")
                    }
             
                }
                //self.tableView.reloadData()
            }
            
            // Convert server json response to NSDictionary
            do {
                //   if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                
                // Print out dictionary
                // print(convertedJsonIntoDict)
                
                // Get value by key
                //  let firstNameValue = convertedJsonIntoDict["locationName"] as? String
                //   print(firstNameValue!)
                
                // }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
     
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewLoadData()
        
        mapView.delegate = self
     
        
        switch UserDefaults.standard.integer(forKey: "locationSelected") {
        case 0:
            print("Annapolis")
            
            var annanpolis: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978445, longitude: -76.492183) }
            
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(annanpolis, 2000, 2000) }
            
            mapView.setRegion(region, animated: true)
            
        case 1:
            print("College Park")
            var CollegePark: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.980481, longitude: -76.937557) }
            
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(CollegePark, 2000, 2000) }
            
            mapView.setRegion(region, animated: true)
            
        default:
            print("no location selected")
        }
        
       /* var annanpolis: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978445, longitude: -76.492183) }
        
        var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(annanpolis, 2000, 2000) }
        
        mapView.setRegion(region, animated: true)
        */
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addingSubtitle(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.977616, longitude: -76.489920) }
        annotation1.coordinate = acme
        
        annotation1.title = "Acme Bar & Grill"
        
        print("closers")
        
        print("no error")
        
        print(AcmeCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = AcmeCircle
        
        switch number {
            
        case 0?:
            
            annotation1.subtitle = "no recent posts"
            
        case 1?:
            
            annotation1.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation1.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation1.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation1.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation1.subtitle = "Line: 20m"
            
        default:
            
            print(self.AcmeCircle as Any)
            
            print("failed..error")
            
        }
        
        let annotationView = MKPinAnnotationView()
        
        annotationView.pinTintColor = UIColor.purple
        
        mapView.removeAnnotation(annotation1)
        
        mapView.addAnnotation(annotation1)
        
    }
    
    func addingSubtitle2(){
        
        var annotation4 = MKPointAnnotation()
        
        var mcgraveys: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9783113, longitude: -76.48699980000004) }
        
        annotation4.coordinate = mcgraveys
        
        annotation4.title = "McGarvey's Saloon & Oyster Bar"
        
        print("closers")
        
        print("no error")
        
        print(McGraveysCircle as Any)
        
        let number = McGraveysCircle
        switch number {
        case 0?:
            
            annotation4.subtitle = "no recent posts"
            
        case 1?:
            
            annotation4.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation4.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation4.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation4.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation4.subtitle = "Line: 20m"
            
        default:
            
            print(self.McGraveysCircle as Any)
            
            print("failed..error")
            
        }
        
        mapView.addAnnotation(annotation4)
    }
    
    func addingSubtitle3(){
        
        var annotation3 = MKPointAnnotation()
        
        var pussers: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9757627, longitude: -76.48553370000002) }
        
        annotation3.coordinate = pussers
        
        annotation3.title = "Pusser's Caribbean Grille"
        
        let number = PussersCircle
        
        switch number {
        case 0?:
            
            annotation3.subtitle = "no recent posts"
            
        case 1?:
            
            annotation3.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation3.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation3.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation3.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation3.subtitle = "Line: 20m"
            
        default:
            
            print(self.PussersCircle)
            
            print("failed..error")
            
        }
        
        self.mapView.addAnnotation(annotation3)
    }
    
    func addingSubtitle4(){
        
        var annotation2 = MKPointAnnotation()
        
        var armadillos: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9779735, longitude: -76.48648589999999) }
        
        annotation2.coordinate = armadillos
        
        annotation2.title = "Armadillos Restaurant"
        
        let number = DillosCircle
        switch number {
        case 0?:
            
            annotation2.subtitle = "no recent posts"
            
            
        case 1?:
            
            annotation2.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation2.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation2.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation2.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation2.subtitle = "Line: 20m"
            
        default:
            
            print(self.DillosCircle as Any)
            
            print("failed..error")
            
        }
        
        self.mapView.addAnnotation(annotation2)
    }
    
    func addingSubtitle5(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978121, longitude: -76.487504) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "The Federal House Bar & Grille"
        
        print("closers")
        
        print("no error")
        
        print(FedHouseCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = FedHouseCircle
        switch number {
        case 0?:
            
            annotation1.subtitle = "no recent posts"
            
        case 1?:
            
            annotation1.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation1.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation1.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation1.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation1.subtitle = "Line: 20m"
            
        default:
            
            print(self.FedHouseCircle as Any)
            
            print("failed..error")
            
        }
        mapView.removeAnnotation(annotation1)
        
        mapView.addAnnotation(annotation1)
    }
    
    func addingSubtitle7(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978029, longitude: -76.486557) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "Dock Street Bar & Grill"
        
        
        print("closers")
        
        print("no error")
        
        print(DockStreetCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = DockStreetCircle
        switch number {
        case 0?:
            
            annotation1.subtitle = "no recent posts"
            
        case 1?:
            
            annotation1.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation1.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation1.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation1.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation1.subtitle = "Line: 20m"
            
        default:
            
            print(self.DockStreetCircle as Any)
            
            print("failed..error")
            
        }
        mapView.removeAnnotation(annotation1)
        
        mapView.addAnnotation(annotation1)
    }
    
    func addingSubtitleBentleys(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.980481, longitude: -76.937557) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "RJ Bentley's Restaurant"
        
        print("closers")
        
        print("no error")
        
        print(IronRooserCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = IronRooserCircle
        switch number {
        case 0?:
            
            annotation1.subtitle = "no recent posts"
            
        case 1?:
            
            annotation1.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation1.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation1.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation1.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation1.subtitle = "Line: 20m"
            
        default:
            
            print(self.IronRooserCircle as Any)
            
            print("failed..error")
            
        }
        
        mapView.removeAnnotation(annotation1)
        
        mapView.addAnnotation(annotation1)
    }
    
    func addingSubtitle9(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978251, longitude: -76.487406) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "City Dock Cafe"
        
        print("closers")
        
        print("no error")
        
        print(CityDockCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = CityDockCircle
        
        switch number {
        case 0?:
            
            annotation1.subtitle = "no recent posts"
            
        case 1?:
            
            annotation1.subtitle = "Line: 0-5m"
            
        case 2?:
            
            annotation1.subtitle = "Line: 5-10m"
            
        case 3?:
            
            annotation1.subtitle = "Line: 10-20m"
            
        case 4?:
            
            annotation1.subtitle = "Line: + 20m"
            
        case 5?:
            
            annotation1.subtitle = "Line: 20m"
            
        default:
            
            print(self.CityDockCircle as Any)
            
            print("failed..error")
        }
        
        mapView.removeAnnotation(annotation1)
        
        mapView.addAnnotation(annotation1)
    }
    func addingSubtitle10(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.977838, longitude: -76.490973) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "Joss Cafe & Sushi Bar"
        
        print("closers")
        
        print("no error")
        
        print(JossCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = JossCircle
        switch number {
        case 0?:
            
            annotation1.subtitle = "no recent posts"
        case 1?:
            annotation1.subtitle = "Line: 0-5m"
        case 2?:
            annotation1.subtitle = "Line: 5-10m"
        case 3?:
            annotation1.subtitle = "Line: 10-20m"
        case 4?:
            annotation1.subtitle = "Line: + 20m"
        case 5?:
            annotation1.subtitle = "Line: 20m"
        default:
            print(self.JossCircle as Any)
            print("failed..error")
        }
        mapView.removeAnnotation(annotation1)
        mapView.addAnnotation(annotation1)
    }
    func addingSubtitle11(){
        
        var annotation1 = MKPointAnnotation()
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.977922, longitude: -76.486307) }
        annotation1.coordinate = acme
        annotation1.title = "Starbucks"
        //  annotation1.subtitle = "working"
        print("closers")
        print("no error")
        print(StarbucksCircle as Any)
        mapView.removeAnnotation(annotation1)
        
        let number = StarbucksCircle
        switch number {
        case 1?:
            annotation1.subtitle = "Line: 0-5m"
        case 2?:
            annotation1.subtitle = "Line: 5-10m"
        case 3?:
            annotation1.subtitle = "Line: 10-20m"
        case 4?:
            annotation1.subtitle = "Line: + 20m"
        case 5?:
            annotation1.subtitle = "Line: 20m"
        default:
            print(self.StarbucksCircle as Any)
            print("failed..error")
        }
        mapView.removeAnnotation(annotation1)
        mapView.addAnnotation(annotation1)
    }
    
    func addingSubtitle12(){
        
        var annotation1 = MKPointAnnotation()
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.977941, longitude: -76.486422) }
        annotation1.coordinate = acme
        annotation1.title = "Storm Bros. Ice Cream Factory"
        //  annotation1.subtitle = "working"
        print("closers")
        print("no error")
        print(StormBrosCircle as Any)
        mapView.removeAnnotation(annotation1)
        
        let number = StormBrosCircle
        switch number {
        case 1?:
            annotation1.subtitle = "Line: 0-5m"
        case 2?:
            annotation1.subtitle = "Line: 5-10m"
        case 3?:
            annotation1.subtitle = "Line: 10-20m"
        case 4?:
            annotation1.subtitle = "Line: + 20m"
        case 5?:
            annotation1.subtitle = "Line: 20m"
        default:
            print(self.StormBrosCircle as Any)
            print("failed..error")
        }
        mapView.removeAnnotation(annotation1)
        mapView.addAnnotation(annotation1)
    }
    
    func addingSubtitle13(){
        
        var annotation1 = MKPointAnnotation()
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978142, longitude: -76.490862) }
        annotation1.coordinate = acme
        annotation1.title = "Annapolis Ice Cream Company"
        //  annotation1.subtitle = "working"
        print("closers")
        print("no error")
        print(AnnapolisIce as Any)
        mapView.removeAnnotation(annotation1)
        
        let number = AnnapolisIce
        switch number {
        case 1?:
            annotation1.subtitle = "Line: 0-5m"
        case 2?:
            annotation1.subtitle = "Line: 5-10m"
        case 3?:
            annotation1.subtitle = "Line: 10-20m"
        case 4?:
            annotation1.subtitle = "Line: + 20m"
        case 5?:
            annotation1.subtitle = "Line: 20m"
        default:
            print(self.AnnapolisIce as Any)
            print("failed..error")
        }
        mapView.removeAnnotation(annotation1)
        mapView.addAnnotation(annotation1)
    }
    
    
    
    
    
    
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        
        self.loadView()
        self.viewDidLoad()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let identifier = "pinAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.animatesDrop = true
        annotationView?.pinTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        return annotationView
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
