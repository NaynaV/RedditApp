//
//  Utility.swift
//  RedditApp
//
//  Created by Nayna on 4/7/21.
//
import Foundation
import UIKit
import SVProgressHUD

class Utility {
    
    class func showProgress(_ message: String = "") {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        if(message == "") {
            SVProgressHUD.show()
        }
        else {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    class func dismissProgress() {
        SVProgressHUD.dismiss()
    }
}
