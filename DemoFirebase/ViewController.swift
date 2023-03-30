//
//  ViewController.swift
//  DemoFirebase
//
//  Created by Fuji on 3/27/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    var remoteConfigManager = RemoteConfigManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteConfigManager.fetchValues(key: RemoteConfigKey.isBackgroundGreen.rawValue, completion: { result in
            guard let result = result else { return }
            DispatchQueue.main.async {
                self.view.backgroundColor = result ? .green : .red
            }
        })
    }


}

