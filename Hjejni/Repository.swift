//
//  Repository.swift
//  Hjejni
//
//  Created by Muntazir on 28/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class Repository {
    
    var sname: String?
    var message: String?
    var remail: String?
    var semail: String?
    var rpid: String?
    var rtable: String?
    var rname: String?
    var pid: String?
    
    
    
    init(json: NSDictionary) {
        self.remail = json["remail"] as? String
        self.sname = json["sname"] as? String
        self.message = json["message"] as? String
        self.semail = json["semail"] as? String
        self.rpid = json["rpid"] as? String
        self.rtable = json["rtable"] as? String
        self.rname = json["rname"] as? String
        self.pid = json["pid"] as? String
        
    }
}
