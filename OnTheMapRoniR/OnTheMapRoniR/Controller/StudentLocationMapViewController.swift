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
    //override func viewWillAppear(_ animated: Bool) {
        
        
        /*let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: OnTheMapClient.LocationDetail.latitudeVal, longitude: OnTheMapClient.LocationDetail.longitudeVal), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        
        self.StudentLocationMap.setRegion(region, animated: true)
        self.LoadDataPoints()
        StudentLocationMap.reloadInputViews()*/
    //}
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //self.LoadDataPoints()
        let barButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        let refreshButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonPressed))
        navigationItem.rightBarButtonItems = [barButtonItemAddLoc,refreshButtonItemAddLoc]
        
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func refreshButtonPressed()
    {
        self.SetWorkingAnimation(animate: true)
        self.StudentLocationMap.removeAnnotations(annotations)
        self.LoadDataPoints()
        //self.SetWorkingAnimation(animate: false)
        //self.reloadInputViews()
    }
    @objc func addButtonPressed()
    {
        //tabBarController?.hidesBottomBarWhenPushed = true
        let addLocVC = storyboard!.instantiateViewController(withIdentifier: "AddLocationVC")  as! AddLocViewController
        navigationController?.pushViewController(addLocVC, animated: true)
        //present(addLocVC, animated: true, completion: {})
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
            guard let data = data else{
                // TODO: 12-05 Show error message when the download of students failed
                print("UNABLE TO LOAD DATA POINTS")
                return
            }
            
            StudentModel.studentList = data
            if (StudentModel.studentList.count <= 0)
            {
                self.SetWorkingAnimation(animate: false)
                self.showLoginFailure(message: "FAILED TO DOWNLOAD STUDENT LOCATIONS.  PLEASE TRY TO REFRESH")
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle:.alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    override func reloadInputViews() {
        LoadDataPoints()
    }
}
