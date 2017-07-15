//
//  DataModel.swift
//  netWorkPop
//
//  Created by karl on 2017/07/15.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

protocol CustomDecodable: Codable {
  static func parse(_ data: Data) -> Self?
}

struct Model: CustomDecodable  {
  var name: String
  var version: String
  var changelog: String
  var updatedAt: Int
  var versionShort: String
  var build: String
  var installUrl: String
  var directInstallUrl: String
  var updateUrl: String
  var binary: [String: Int]
  
  enum CodingKeys: String, CodingKey {
    case name
    case version
    case changelog
    case updatedAt = "updated_at"
    case versionShort
    case build
    case installUrl = "install_url"
    case directInstallUrl = "direct_install_url"
    case updateUrl = "update_url"
    case binary
  }
  
}

extension Model {
  static func parse(_ data: Data) -> Model? {
    let decoder = JSONDecoder()
    let model = try? decoder.decode(Model.self, from: data)
    return model
  }
}

