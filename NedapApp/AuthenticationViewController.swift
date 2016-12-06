//
//  ViewController.swift
//  NedapApp
//
//  Created by Coos on 06/12/16.
//  Copyright © 2016 Coos. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {

    @IBAction func loginButton(_ sender: UIButton) {
        let authenticationContext = LAContext()
        var error:NSError?
        
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
        }
        
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "If your awesome you may enter", reply: { [unowned self] (success, error) -> Void in
            
            if(success) {
                self.navigateToAuthenticatedViewController()
                
            }else {
                if let error = error {
                    let message = self.errorMessageForLAErrorCode(error._code)
                    self.showAlertViewAfterEvaluatingPolicyWithMessage(message)
                    
                }
            }
        })
    }
        

    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        showAlertWithTitle("Error", message: "This device does not have a TouchID sensor.")
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage( _ message:String ){
        showAlertWithTitle("Error", message: message)
    }
    
    func showAlertWithTitle( _ title:String, message:String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { () -> Void in
            
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func errorMessageForLAErrorCode( _ errorCode:Int) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.Code.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.Code.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.Code.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.Code.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.Code.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.Code.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.Code.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.Code.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.Code.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
    }
    
    func navigateToAuthenticatedViewController(){
        
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier:"LoggedInViewController") {
            
            DispatchQueue.main.async { () -> Void in
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
        }
    }


}

