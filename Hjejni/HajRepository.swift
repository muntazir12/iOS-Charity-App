//
//  HajRepository.swift
//  Hjejni
//
//  Created by Muntazir on 28/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class HajRepository {
    
    var name: String?
    var country: String?
    var pid: String?
    var dob: String?
    var email: String?
    
    init(json: NSDictionary) {
        self.name = json["name"] as? String
        self.country = json["country"] as? String
        self.pid = json["pid"] as? String
        self.dob = json["age"] as? String
        self.email = json["email"] as? String
    }

}
