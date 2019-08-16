//
//  LoginRequestDTO.swift
//  App
//
//  Created by Suhel Chakraborty on 13/08/19.
//

import Foundation
import Vapor

struct SigninRequestDTO: Content {
    
    let email: String
    let password: String
    
}
