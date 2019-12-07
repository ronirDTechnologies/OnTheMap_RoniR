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

    
    @IBOutlet weak var LoadingMapActivityIdicator: UIActivityIndicatorView!
    @IBOutlet weak var AddLocationBtn: UIBarButtonItem!
    @IBOutlet weak var StudentLocationMap: MKMapView!
    var annotations = [MKPointAnnotation]()
    
    @IBAction func LogoutBtn(_ sender: Any)
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.reloadInputViews()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        let barButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        let refreshButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonPressed))
        navigationItem.rightBarButtonItems = [barButtonItemAddLoc,refreshButtonItemAddLoc]
    }
    
    @objc func refreshButtonPressed()
    {
        // Show activity indicator when refreshed button is tapped
        self.SetWorkingAnimation(animate: true)
        self.StudentLocationMap.removeAnnotations(annotations)
        self.LoadDataPoints()
      
    }
    
    @objc func addButtonPressed()
    {
        let addLocVC = storyboard!.instantiateViewController(withIdentifier: "AddLocationVC")  as! AddLocViewController
        navigationController?.pushViewController(addLocVC, animated: true)
    }
    
    func SetWorkingAnimation(animate: Bool)
    {
           if animate
           {
               LoadingMapActivityIdicator.startAnimating()
           }
           else
           {
               LoadingMapActivityIdicator.stopAnimating()
           }
    }
    
    func LoadDataPoints()
    {
        OnTheMapClient.getStudentInformation(numberOfStudentsToRetrieve: "100"){(data,error) in
            guard let data = data else
            {
                print("UNABLE TO LOAD DATA POINTS")
                return
            }
            
            StudentModel.studentList = data
            
            // If no student locations are downloaded notify users
            if (StudentModel.studentList.count <= 0)
            {
                self.SetWorkingAnimation(animate: false)
                self.showLoginFailure(message: "FAILED TO DOWNLOAD STUDENT LOCATIONS.  PLEASE TRY TO REFRESH", titleVal: "STUDENT DOWNLOAD FAILED")
                print("Students failed to download")
                return
            }
            
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
                self.annotations.append(annotation)
                
            }
            self.SetWorkingAnimation(animate: false)
            self.StudentLocationMap.addAnnotations(self.annotations)
            
        }
    }
    //*** Use code from Udacity Sample
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil
        {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        else
        {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    //*** Use code from Udacity Sample
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if control == view.rightCalloutAccessoryView
        {
            if let toOpen = view.annotation?.subtitle!
            {
                UIApplication.shared.open(URL(string: toOpen)! , options: [:], completionHandler: nil)
            }
        }
    }
 
    func showLoginFailure(message: String, titleVal: String)
    {
        let alertVC = UIAlertController(title: titleVal, message: message, preferredStyle:.alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func reloadInputViews()
    {
        LoadDataPoints()
    }
}
