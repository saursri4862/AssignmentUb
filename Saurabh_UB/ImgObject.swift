//
//  ImgObject.swift
//  Saurabh_UB
//
//  Created by saurabh srivastava on 11/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ImgObject: NSObject {
    
    var id = ""
    var secret = ""
    var server = ""
    var farm = 0
    var title = ""
    
    func updateData(_ data:[String:Any]){
        if let str = data["id"] as? String{
            id = str
        }
        if let str = data["secret"] as? String{
            secret = str
        }
        if let str = data["server"] as? String{
            server = str
        }
        if let str = data["title"] as? String{
            title = str
        }
        if let int = data["farm"] as? Int{
            farm = int
        }
    }

}
