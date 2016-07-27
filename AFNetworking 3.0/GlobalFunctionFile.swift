//
//  GlobalFunctionFile.swift
//  AFNetworking 3.0
//
//  Created by MindLogic Solutions on 25/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import Foundation

//AlertView add by Jack 25-07-2016
func showAlert(title:String,message:String){
    let alert:UIAlertView=UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
    alert.show()
}

//Set Border for textField add by Jack 25-07-2016
func setborderForTextField(txtName:UITextField){
    txtName.layer.borderWidth = 1
    txtName.layer.borderColor = UIColor(red: 255.0/255.0, green: 6.0/255.0, blue: 99.0/255.0, alpha: 1.0).CGColor
}

//Set Pedding space for textField add by Jack 25-07-2016
func setPeddingSpaceForTextField(txtName:UITextField){
    let paddingView: UIView = UIView(frame: CGRectMake(0, 0, 20, 20))
    txtName.leftView = paddingView
    txtName.leftViewMode = .Always
}

//Set Placeholder font color for textField add by Jack 25-07-2016
func textFieldPlaceHolderColor(txtName:UITextField,placeholderName:String){
    txtName.attributedPlaceholder = NSAttributedString(string:placeholderName,
                                                       attributes:[NSForegroundColorAttributeName:UIColor.whiteColor()])
}

//email verification function
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}

















