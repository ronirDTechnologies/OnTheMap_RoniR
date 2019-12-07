//
//  AddLocViewController.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 11/12/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocViewController: UIViewController,UINavigationControllerDelegate,MKMapViewDelegate {
    @IBOutlet weak var AddressTxtBx: UITextField!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var UrlTxtBx: UITextField!
    @IBOutlet weak var FinishBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBOutlet weak var FoundLocationMap: MKMapView!
    
    @IBAction func FinishPostingLocation(_ sender: Any)
    {
        let urlStr = UrlTxtBx.text ?? ""
        OnTheMapClient.postStudentInformationLocation(mapStringLocation: AddressTxtBx.text ?? "", mediaUrlStr: urlStr, completion: self.HandlePostUserResponse(successfulPost:error:))
    }
    
    @IBAction func FindLocationBtn(_ sender: Any)
    {
        // 1. Check location field is not blank
         if self.AddressTxtBx.text == ""
         {
          showLoginFailure(message: "THE ADDRESS CANNOT BE BLANK.  PLEASE FILL IN CITY / STATE", titleVal: "INVALID ADDRESS")
             return
         }
        
        if self.UrlTxtBx.text == ""
        {
            showLoginFailure(message: "THE URL CANNOT BE BLANK.  PLEASE FILL IN URL", titleVal: "INVALID URL")
            return
        }
         
         
        // 3. Check URL is valid
         guard let urlVal = URL(string: UrlTxtBx.text ?? "na") else { return }
         let validURl = UIApplication.shared.canOpenURL(urlVal)
         if !validURl
         {
             showLoginFailure(message: "URL SHOULD BE FORMED AS HTTPS://exampleUrl.com", titleVal: "INVALID URL")
             return
         }
         
         SetWorkingAnimation(animate: true)
         if OnTheMapClient.validateAddressEntered(address: self.AddressTxtBx.text ?? "", completion: self.HandleLocationCheckResponse(locationExists: error:))
         {
             
         }
         
    }
    
    func HandleLocationCheckResponse(locationExists: Bool, error: Error?)
    {
        SetWorkingAnimation(animate: false)
        if locationExists
        {
              
            print("WE FOUND THE ENTERED LOCATION")
            print("LOCATION EXISTS ************** ")
            print("LATITUDE: \(OnTheMapClient.LocationDetail.latitudeVal)")
            print("LONGITUDE: \(OnTheMapClient.LocationDetail.longitudeVal)")
            
            SetMapToUserLocation()
            ShowHideUserEnteredLocation(mapHiddenFlag: false)
              
        }
            
          else
        {
              // Notify user to input a valid address
              showLoginFailure(message: "PLEASE ENTER ADDRESS IN THE FORMAT CITY, STATE OR MAKE SURE YOUR SPELLING IS CORRECT", titleVal: "INVALID ADDRESS")
        }
    }
    
    func HandlePostUserResponse(successfulPost:Bool, error: Error?)
    {
        print("THE POSTING HAS THE FOLLOWING STATUS \(successfulPost)")
        print("LATITUDE: \(OnTheMapClient.LocationDetail.latitudeVal)")
        print("LONGITUDE: \(OnTheMapClient.LocationDetail.longitudeVal)")
        
        if(successfulPost)
        {
            // TODO 12-02-2019: Dismiss view controller
            navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: {})
        }
            
        else
        {
            showLoginFailure(message: "FAILED TO POST USER LOCATION", titleVal: "POSTING FAILURE")
        }
    }
    
    func SetMapToUserLocation()
    {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: OnTheMapClient.LocationDetail.latitudeVal, longitude: OnTheMapClient.LocationDetail.longitudeVal), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
               
        self.FoundLocationMap.setRegion(region, animated: true)
        
        var annotations = [MKPointAnnotation]()
        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: OnTheMapClient.LocationDetail.latitudeVal, longitude: OnTheMapClient.LocationDetail.longitudeVal)
        
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        let locationTextVal = AddressTxtBx.text ?? "NA"
        annotation.coordinate = coordinate
        annotation.title = "\(locationTextVal)"
        annotation.subtitle = ""
        // Finally we place the annotation in an array of annotations.
        annotations.append(annotation)
        self.FoundLocationMap.addAnnotations(annotations)
        self.FoundLocationMap.reloadInputViews()
    }
    
    func ShowHideUserEnteredLocation(mapHiddenFlag:Bool)
    {
        
        // Hide text fields not used
        if(mapHiddenFlag == false)
        {
            AddressTxtBx.isHidden = true
            UrlTxtBx.isHidden = true
        }
        else
        {
            AddressTxtBx.isHidden = false
            UrlTxtBx.isHidden = false
        }
        
        // Show Map and finish buttons
        FoundLocationMap.isHidden = mapHiddenFlag
        FinishBtn.isHidden = mapHiddenFlag
    }
    
    func SetWorkingAnimation(animate: Bool)
    {
        if animate
        {
            ActivityIndicator.startAnimating()
        }
        else
        {
            ActivityIndicator.stopAnimating()
        }
    }
    func showLoginFailure(message: String, titleVal: String)
    {
        let alertVC = UIAlertController(title: titleVal, message: message, preferredStyle:.alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //*** Use code from Udacity Sample
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        let reuseId = "pinFoundLoc"
        
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
}
