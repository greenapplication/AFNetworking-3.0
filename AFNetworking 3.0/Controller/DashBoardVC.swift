//
//  DashBoardVC.swift
//  AFNetworking 3.0
//
//  Created by MindLogic Solutions on 25/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit

class DashBoardVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK: declaration of variable
    @IBOutlet weak var tblView: UITableView!
    
    var arrayOfID:[String] = []
    var arrayOfFirstName:[String] = []
    var arrayOfLastName:[String] = []
    var arrayOfLocation:[String] = []

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DisplayShadChan()

        // Do any additional setup after loading the view.
    }
    
    //MARK:tableview delegate and datasource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfID.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(arrayOfFirstName[indexPath.row]) \(arrayOfLastName[indexPath.row]) \(arrayOfLocation[indexPath.row])"
        
        cell.textLabel?.font = UIFont.systemFontOfSize(12)
        
        return cell
    }
    
    //MARK: DisplayShadChan Function
    func DisplayShadChan(){
        /*=======================================================================
         * Request Handler: AFNetworking 3.0
         * Function Purpose: for display Shadchan add by Jack 25-07-2016
         * Function Request Type: GET
         * Function Calls From: RequestHandlerFile
         * API and Keys Calls From: ServerConstantFile
         * AlertView Calls From: GlobalFunctionFile
         * ====================================================================*/
        
        if Reachability.isConnectedToNetwork() {
            SVProgressHUD.showWithStatus("Loading..")
            SendServerRequest(kGET, baseURL: getallshadchanAPI, param: "", requestCompleted: {(success,msg,json) in
                
                if success
                {
                    if json[ksuccess] as! Int == 1
                    {
                        let json = json[kshadchaninfo]as! NSArray
                        
                        for json in json{
                            
                            if json[kid] is String{
                                if !(json[kid] is NSNull){
                                    self.arrayOfID.append(json[kid]as! String)
                                }
                            }
                            
                            if json[kfname] is String{
                                if !(json[kfname] is NSNull){
                                    self.arrayOfFirstName.append(json[kfname]as! String)
                                }
                            }
                            
                            if json[klname] is String{
                                if !(json[klname] is NSNull){
                                    self.arrayOfLastName.append(json[klname]as! String)
                                }
                            }
                            
                            if json[klocation] is String{
                                if !(json[klocation] is NSNull){
                                    self.arrayOfLocation.append(json[klocation]as! String)
                                }
                            }
                        }
                        self.tblView.reloadData()
                    }
                    else if json[ksuccess] as! Int == 0
                    {
                        SVProgressHUD.dismiss()
                        showAlert("", message: "Faild to retrive data")
                    }

                }
                else
                {
                    SVProgressHUD.dismiss()
                    showAlert("Server didnt get any responding", message: "Please try again")
                }
                
            })
            
        }else{
            
            SVProgressHUD.dismiss()
            showAlert("No Internet Connection", message: "Make sure your device is connected to the internet.")
        }
        
        //======================end function for DisplayShadChan==========================
    }

}
