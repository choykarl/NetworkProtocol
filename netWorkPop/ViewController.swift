//
//  ViewController.swift
//  netWorkPop
//
//  Created by karl on 2017/07/14.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let request = Request()
    NetworkSender().send(request) { (reslt) in
      switch reslt {
      case .success(let model as Request.Response, _):
        print(model.name)
      case .error(let error):
        print(error)
      default:
        break
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

