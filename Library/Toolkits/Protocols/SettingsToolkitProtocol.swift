//
//  SettingsToolkitProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol SettingsToolkitProtocol {
    
    /// 写入本地设置
    /// - Parameters:
    ///   - settingName: 设置名称
    ///   - value: 值
    func writeLocalSetting<T>(settingName: String, value: T)
    
    /// 读取本地设置
    /// - Parameters:
    ///   - settingName: 设置名称
    ///   - defaultValue: 默认值
    /// - Returns: 设置的值
    func readLocalSetting<T>(settingName: String, defaultValue: T) -> T?
    
    /// 删除本地设置
    /// - Parameter settingName: 设置名称
    func deleteLocalSetting(settingName: String)
    
    /// 检查设置是否存在
    /// - Parameter settingName: 设置名称
    /// - Returns: 是否存在
    func isSettingKeyExist(settingName: String) -> Bool
}
