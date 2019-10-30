//
//  StudentLocationMapViewController.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/23/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import UIKit
import MapKit

class StudentLocationMapViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var AddLocationBtn: UIBarButtonItem!
    @IBOutlet weak var StudentLocationMap: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: OnTheMapClient.LocationDetail.latitudeVal, longitude: OnTheMapClient.LocationDetail.longitudeVal), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        
        self.StudentLocationMap.setRegion(region, animated: true)
        self.LoadDataPoints()
        StudentLocationMap.reloadInputViews()
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.LoadDataPoints()
        let barButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        let refreshButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonPressed))
        //OnTheMapClient.postStudentInformationLocation()
        navigationItem.rightBarButtonItems = [refreshButtonItemAddLoc,barButtonItemAddLoc]
        
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func addButtonPressed()
    {
        let addLocVC = storyboard!.instantiateViewController(withIdentifier: "AddLocationVC")  as! AddLocationViewController
        navigationController?.pushViewController(addLocVC, animated: true)
    }
    @objc func refreshButtonPressed()
    {
           
    }
    func LoadDataPoints()
    {
        OnTheMapClient.getStudentInformation(numberOfStudentsToRetrieve: "100"){(data,error) in
            guard let data = data else{
                return
            }
            var annotations = [MKPointAnnotation]()
            StudentModel.studentList = data
            
            for student in data{
                // Notice that the float values are being used to create CLLocationDegree values.
                // This is a version of the Double type.
                let lat = CLLocationDegrees(student.latitude)
                let long = CLLocationDegrees(student.longitude)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let firstName = student.firstName
                let lastName = student.lastName
                let mediaURL = student.mediaURL
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
                
            }
            self.StudentLocationMap.addAnnotations(annotations)
        }
    }
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: toOpen)! , options: [:], completionHandler: nil)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func reloadInputViews() {
        LoadDataPoints()
    }
}
