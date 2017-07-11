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
    
    private func loadData1() {
        
        var task: URLSessionDataTask
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl! as URL);
        
        request.httpMethod = "GET"
        
        print("load1.5")
        // ChipotleCircle = 3
        
        task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            
            print("working")
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let array = json as? [Any] else {
                print("error")
                return
            }
            
        for firstobject in array {
                
                guard let dictionary = firstobject as? [String: Any] else {
                    
                    print("error")
                    return
                }
            
                guard let circleRating = dictionary["circleRating"] as? String,
                    let Time = dictionary["timeDate"] as? String,
                    let location = dictionary["locationName"] as? String
                    else {
                        print("error")
                        return
                }
                
                let dateFormatter = DateFormatter()
            
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
                let date1 = dateFormatter.date(from: Time)!
                
                let TimeNow = date1.timeIntervalSinceNow
            
                dateFormatter.dateFormat = "HH"
            
                let dateString = dateFormatter.string(from: date1 )
            
                print(dateString)
                
                let dataPiece = BarDisplayDataPiece(waitTime: 0, postTime: "")
            
                print("after")
            
                let name = location
            
            switch name {
                
                case "Armadillos":
                    
                    print("")
                    
                    self.DillosCircle = Int(circleRating)!
                    
                    print("here is chipoptle")
                    
                    print(self.DillosCircle as Any)
                    
                case "McGarveys":
           
                    self.McGraveysCircle = Int(circleRating)!
                
                case "Pussers":
                
                    self.PussersCircle = Int(circleRating)!
                
                case "Acme":
                    self.AcmeCircle = Int(circleRating)!
              
                case "Federal House":
                    self.FedHouseCircle = Int(circleRating)!
                    
                case "Joss":
                    self.JossCircle = Int(circleRating)!
                    
                case "City Dock Cafe":
                    self.CityDockCircle = Int(circleRating)!
                    
                case "Iron Rooster":
                    self.IronRooserCircle = Int(circleRating)!
                    
                case "Storm Bros":
                    self.StormBrosCircle = Int(circleRating)!
                    
                case "Starbucks":
                    self.StarbucksCircle = Int(circleRating)!
                    
                case "Annapolis Ice Cream Co":
                    self.AnnapolisIce = Int(circleRating)!
                    
                case "Dock Street":
                    self.DockStreetCircle = Int(circleRating)!
                    
                default:
                    print("error")
                }
            
            }
            
            guard array.last != nil else {
                print("error1")
                return
            }
            
            self.addingSubtitle()
            
            self.addingSubtitle2()
            
            self.addingSubtitle3()
            
            self.addingSubtitle4()
            
            self.addingSubtitle5()
           
            self.addingSubtitle7()
        }
        
        task.resume()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData1()
        
        mapView.delegate = self
        
        var annanpolis: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978445, longitude: -76.492183) }
        
        var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(annanpolis, 1000, 1000) }
        
        mapView.setRegion(region, animated: true)
    
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
    
    func addingSubtitle8(){
        
        var annotation1 = MKPointAnnotation()
        
        var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978333, longitude: -76.487309) }
        
        annotation1.coordinate = acme
        
        annotation1.title = "Iron Rooster"
       
        print("closers")
        
        print("no error")
        
        print(IronRooserCircle as Any)
        
        mapView.removeAnnotation(annotation1)
        
        let number = IronRooserCircle
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
