//
//  SecureEnclaveAccessControl.swift
//  Valet
//
//  Created by Dan Federman on 9/18/17.
//  Copyright © 2017 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation


public enum SecureEnclaveAccessControl: CustomStringConvertible {
    /// Access to keychain elements requires user presence verification via Touch ID, Face ID, or device Passcode. Keychain elements are still accessible by Touch ID even if fingers are added or removed. Touch ID does not have to be available or enrolled.
    @available(macOS 10.11, iOS 8.0, *)
    case userPresence
    
    /// Access to keychain elements requires user presence verification via Face ID, or any finger enrolled in Touch ID. Keychain elements remain accessible via Face ID or Touch ID  after faces or fingers are added or removed. Face ID must be enabled with at least one face enrolled, or Touch ID must be available and at least one finger must be enrolled.
    @available(macOS 10.12, iOS 9.0, *)
    case biometricAny
    
    /// Access to keychain elements requires user presence verification via the face currently enrolled in Face ID, or fingers currently enrolled in Touch ID. Previously written keychain elements become inaccessible when faces or fingers are added or removed. Face ID must be enabled with at least one face enrolled, or Touch ID must be available and at least one finger must be enrolled.
    @available(macOS 10.12, iOS 9.0, *)
    case biometricCurrentSet
    
    /// Access to keychain elements requires user presence verification via device Passcode.
    @available(macOS 10.11, iOS 9.0, *)
    case devicePasscode
    
    // MARK: CustomStringConvertible
    
    public var description: String {
        switch self {
        case .userPresence:
            /*
             VALSecureEnclaveValet v1.0-v2.0.7 used UserPresence without a suffix – the concept of a customizable AccessControl was added in v2.1.
             For backwards compatibility, do not append an access control suffix for UserPresence.
             */
            return ""
        case .biometricAny:
            return "_AccessControlTouchIDAnyFingerprint"
        case .biometricCurrentSet:
            return "_AccessControlTouchIDCurrentFingerprintSet"
        case .devicePasscode:
            return "_AccessControlDevicePasscode"
        }
    }
    
    // MARK: Internal Properties
    
    internal var secAccessControl: SecAccessControlCreateFlags {
        switch self {
        case .userPresence:
            return .userPresence
        case .biometricAny:
            return .touchIDAny
        case .biometricCurrentSet:
            return .touchIDCurrentSet
        case .devicePasscode:
            return .devicePasscode
        }
    }
}
