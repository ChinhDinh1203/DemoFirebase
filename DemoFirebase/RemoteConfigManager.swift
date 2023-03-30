//
//  RemoteConfigManager.swift
//  DemoFirebase
//
//  Created by Fuji on 3/28/23.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case backgroundApp = "background_color"
    case titleApp = "title_label"
    case isBackgroundGreen = "is_background_green"
}

struct RemoteConfigManager {
    static let baseBackgroundColor: String = "red"
    static let titleApp: String = "OPN"
    static let shared = RemoteConfigManager()
    private var remoteConfig: RemoteConfig
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        self.setDefaultValue()
    }
    
    func setDefaultValue() {
        let title = RemoteConfigManager.titleApp as NSString
        remoteConfig.setDefaults([RemoteConfigKey.titleApp.rawValue: title])
    }
    
    func getValueString(fromKey key: RemoteConfigKey) -> String {
        if let value = self.remoteConfig.configValue(forKey: key.rawValue).stringValue {
            return value
        }
        return ""
    }
    
    func fetchValues(key: String, completion: @escaping (Bool?) -> Void) {
        setDefaultValue()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { result, error in
            if result == .success, error == nil {
                self.remoteConfig.activate(completion: { changed, error in
                    guard error == nil else {
                        return
                    }
                    let value = self.remoteConfig.configValue(forKey: key).boolValue
                    completion(value)
                })
            } else {
                completion(nil)
            }
        }
    }
    
}
