//
//  Friend.swift
//  MyFriends
//
//  Created by 김지수 on 2021/08/08.
//

import Foundation

struct Friend : Codable {
  struct Address : Codable {
    let country : String
    let city : String
  }
  let name : String
  let age : Int
  let address_info : Address
}
