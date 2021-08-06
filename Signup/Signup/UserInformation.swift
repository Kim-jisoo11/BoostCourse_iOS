//
//  UserInformation.swift
//  Signup
//
//  Created by 김지수 on 2021/08/06.
//

import Foundation

class UserInformation {
  static let shared: UserInformation = UserInformation()
  
  var name: String?
  var age: String?
}
