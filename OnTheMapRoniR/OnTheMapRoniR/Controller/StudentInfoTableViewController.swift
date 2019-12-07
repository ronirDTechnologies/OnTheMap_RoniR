//
//  StudentInfoTableViewController.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/18/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation
import UIKit

class StudentInfoTableViewController: UIViewController{
    @IBOutlet weak var StudentInfoTV: UITableView!
    @IBOutlet weak var TableActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let barButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        let refreshButtonItemAddLoc = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonList))
        navigationItem.rightBarButtonItems = [barButtonItemAddLoc,refreshButtonItemAddLoc]
        OnTheMapClient.getStudentInformation(numberOfStudentsToRetrieve: "100"){(data,error) in
            guard let data = data else{
                // TODO 12-05: Show Error Message if download fails
                return
            }
            StudentModel.studentList = data
            self.StudentInfoTV.reloadData()
        }
       
        
    }
    @objc func refreshButtonList()
    {
        //self.SetWorkingAnimation(animate: true)
        OnTheMapClient.getStudentInformation(numberOfStudentsToRetrieve: "100"){(data,error) in
            guard let data = data else{
                // TODO 12-05: Show error message if download fails
                
                return
            }
            StudentModel.studentList = data
            
            if(StudentModel.studentList.count == 0)
            {
                self.showLoginFailure(message: "Unable to download student data.  Try to refresh")
            }
            
            self.StudentInfoTV.reloadData()
        }
    }
    @objc func addButtonPressed()
    {
        //tabBarController?.hidesBottomBarWhenPushed = true
        let addLocVC = storyboard!.instantiateViewController(withIdentifier: "AddLocationVC")  as! AddLocViewController
        navigationController?.pushViewController(addLocVC, animated: true)
        
    }
    @IBAction func LogoutBtn(_ sender: Any)
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StudentInfoTV.reloadData()
    }
    func SetWorkingAnimation(animate: Bool)
    {
           if animate
           {
               TableActivityIndicator.startAnimating()
           }
           else
           {
               TableActivityIndicator.stopAnimating()
           }
    }
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Failed Loading Student Locations", message: message, preferredStyle:.alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
   
    
}

extension StudentInfoTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentInfoCell") as! StudentInfoTableViewCell
        let studentVals = StudentModel.studentList
        cell.StudentNameLbl.text =  studentVals[indexPath.row].firstName + " " + studentVals[indexPath.row].lastName
        
        cell.StudentUrlLbl.text = studentVals[indexPath.row].mediaURL
        
        //cell.setNeedsLayout()
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        UIApplication.shared.open(URL(string: StudentModel.studentList[indexPath.row].mediaURL)!, options: [:], completionHandler: nil)
        
        
    }
    
    
}
