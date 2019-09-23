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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnTheMapClient.getStudentInformation(numberOfStudentsToRetrieve: "100"){(data,error) in
        
            StudentModel.studentList = data
            self.StudentInfoTV.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StudentInfoTV.reloadData()
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
        
        //TODO: 09-23-2019 Check validity of URL before launching
        UIApplication.shared.open(URL(string: StudentModel.studentList[indexPath.row].mediaURL)!, options: [:], completionHandler: nil)
        
        /*selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)*/
    }
    
    
}
