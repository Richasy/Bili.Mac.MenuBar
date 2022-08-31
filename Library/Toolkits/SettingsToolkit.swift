//
//  SettingsToolkit.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class SettingsToolkit: SettingsToolkitProtocol {
    
    private let container = UserDefaults.standard
    
    func writeLocalSetting<T>(settingName: String, value: T) {
        container.set(value, forKey: settingName)
    }
    
    func readLocalSetting<T>(settingName: String, defaultValue: T) -> T? {
        if isSettingKeyExist(settingName: settingName) {
            let v = container.object(forKey: settingName)
            return v as? T
        } else {
            writeLocalSetting(settingName: settingName, value: defaultValue)
            return defaultValue
        }
    }
    
    func deleteLocalSetting(settingName: String) {
        guard isSettingKeyExist(settingName: settingName) else {
            return
        }
        
        container.removeObject(forKey: settingName)
    }
    
    func isSettingKeyExist(settingName: String) -> Bool {
        container.object(forKey: settingName) != nil
    }
}
