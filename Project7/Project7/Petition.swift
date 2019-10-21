//
//  Petition.swift
//  Project7
//
//  Created by Karol Harasim on 28/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
