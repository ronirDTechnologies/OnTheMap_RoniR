//
//  AddLocationViewController.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/24/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var CancelLocationAdd: UIBarButtonItem!
    @IBOutlet weak var AddressTxtBx: UITextField!
    @IBOutlet weak var UrlTxtBx: UITextField!
    
    @IBAction func CancelAddLocation(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func FindLocationBtn(_ sender: Any) {
        // 1. Check location field is not blank
        if self.AddressTxtBx.text == ""
        {
         showLoginFailure(message: "THE ADDRESS CANNOT BE BLANK.  PLEASE FILL IN CITY / STATE")
            return
        }
        // 3. Check URL is valid
        guard let urlVal = URL(string: UrlTxtBx.text ?? "na") else { return }
        let validURl = UIApplication.shared.canOpenURL(urlVal)
        if !validURl {
            showLoginFailure(message: "INVALID URL.  SHOULD BE FORMED AS HTTPS://exampleUrl.com")
            return
        }
        
        
        // 2. TODO: 09-27 - Validate address returns longitude, latitude
        
        
        if OnTheMapClient.validateAddressEntered(address: self.AddressTxtBx.text ?? "", completion: self.HandleLocationCheckResponse(locationExists: error:)){
            
        }
        //navigationController?.dismiss(animated: true, completion: {})
        //print("THE POSTING HAS THE FOLLOWING STATUS ")
        //print("LATITUDE: \(OnTheMapClient.self.LocationDetail.latitudeVal)")
        //print("LONGITUDE: \(OnTheMapClient.LocationDetail.longitudeVal)")
        //findCityCoordinates(cityName: AddressTxtBx.text ?? "")
    }
    func HandlePostUserResponse(successfulPost:Bool, error: Error?)
    {
        print("THE POSTING HAS THE FOLLOWING STATUS \(successfulPost)")
        print("LATITUDE: \(OnTheMapClient.LocationDetail.latitudeVal)")
        print("LONGITUDE: \(OnTheMapClient.LocationDetail.longitudeVal)")
        self.dismiss(animated: true, completion: {})
        
    }
    func HandleLocationCheckResponse(locationExists: Bool, error: Error?)
    {
        if locationExists{
            print("WE FOUND THE ENTERED LOCATION")
                
            print("LOCATION EXISTS ************** ")
            print("LATITUDE: \(OnTheMapClient.LocationDetail.latitudeVal)")
            print("LONGITUDE: \(OnTheMapClient.LocationDetail.longitudeVal)")
            let urlStr = UrlTxtBx.text ?? ""
          
            OnTheMapClient.postStudentInformationLocation(mapStringLocation: AddressTxtBx.text ?? "", mediaUrlStr: urlStr, completion: self.HandlePostUserResponse(successfulPost:error:))
            
        }
        else{
            // Notify user to input a valid address
            showLoginFailure(message: "YOU ENTERED AN INVALID ADDRESS.  PLEASE ENTER IN THE FORMAT CITY, STATE OR MAKE SURE YOUR SPELLING IS CORRECT")
         
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*func findCityCoordinates(cityName: String)  {
        let locationManager = CLGeocoder()
        locationManager.geocodeAddressString(cityName, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            let placemark = placemarks![0]
            let latVal = placemark.location!.coordinate.latitude
            let longVal = placemark.location?.coordinate.longitude
        } )
                                             
    }*/

    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //if segue.identifier == "AddLocationSeg"{
         //   if let destinationVC = segue.destination as? AddLocationViewController {
                   //destinationVC.numberToDisplay = counter
            
            //DispatchQueue.main.async
              //  {
                   /* let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: OnTheMapClient.LocationDetail.latitudeVal, longitude: OnTheMapClient.LocationDetail.longitudeVal), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
                    
                    destinationVC.StudentLocationMap.setRegion(region, animated: true)*/
                    //destinationVC.LoadDataPoints()
                    //destinationVC.StudentLocationMap.reloadInputViews()
                    //destinationVC.self.reloadInputViews()
                //let annotation = MKPointAnnotation()
                //annotation.coordinate = location.coordinate
                //self.mapView.addAnnotation(annotation)
               //}
            }
    


