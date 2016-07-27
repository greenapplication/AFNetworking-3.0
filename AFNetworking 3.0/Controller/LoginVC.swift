//
//  LoginVC.swift
//  AFNetworking 3.0
//
//  Created by MindLogic Solutions on 25/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: declaration of variable
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden=true
        // Do any additional setup after loading the view.
    }
    
    //MARK: Login Function
    @IBAction func buttonLogin(sender: AnyObject) {
        /*=======================================================================
         * Request Handler: AFNetworking 3.0
         * Function Purpose: for login add by Jack 25-07-2016
         * Function Request Type: POST
         * Function Calls From: RequestHandlerFile
         * API and Keys Calls From: ServerConstantFile
         * AlertView Calls From: GlobalFunctionFile
         * ====================================================================*/
        if txtUsername.text == ""{
            showAlert("", message: "Enter username")
        }else if txtPassword.text == ""{
            showAlert("", message: "Enter password")
        }else{
            
            if Reachability.isConnectedToNetwork() {
                SVProgressHUD.showWithStatus("Loading..")
                let param = [ktxtUsername: self.txtUsername.text!, ktxtPassword: self.txtPassword.text!]
                SendServerRequest(kPOST, baseURL: loginAPI, param: param, requestCompleted: {(success,msg,json) in
                    
                    if success
                    {
                        if json[ksuccess] as! Int == 1
                        {
                            let json = json[kuserlogin] as! NSArray
                            
                            for json in json{
                                
                                if json[kuserLevel] is String{
                                    if json[kuserLevel] != nil{
                                        SVProgressHUD.dismiss()
                                        let nextVC=self.storyboard?.instantiateViewControllerWithIdentifier("DashBoardVC")as! DashBoardVC
                                        self.navigationController?.pushViewController(nextVC, animated: true)
                                    }
                                }
                            }
                        }
                        else if json[ksuccess] as! Int == 0
                        {
                            SVProgressHUD.dismiss()
                            showAlert("", message: "Username or password wrong!")
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
            
        }
        
        //======================end function for login==========================
    }
    
       
}
