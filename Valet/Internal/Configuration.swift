//
//  Configuration.swift
//  Valet
//
//  Created by Dan Federman and Eric Muller on 9/16/17.
//  Copyright © 2017 Square, Inc.
//
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


internal enum Configuration: CustomStringConvertible {
    case valet(Valet.Flavor)
    case secureEnclave(SecureEnclave.Flavor)
    
    // MARK: CustomStringConvertible
    
    internal var description: String {
        switch self {
        case let .valet(flavor):
            switch flavor {
            case .vanilla:
                return "VALValet"
            case .iCloud:
                return "VALSynchronizableValet"
            }
            
        case let .secureEnclave(flavor):
            switch flavor {
            case .singlePrompt:
                return "VALSinglePromptSecureEnclaveValet"
            case .alwaysPrompt:
                return "VALSecureEnclaveValet"
            }
        }
    }
    
    // MARK: Internal Properties
    
    internal var accessability: Accessibility {
        switch self {
        case let .valet(flavor):
            switch flavor {
            case let .vanilla(accessibility):
                return accessibility
            case let .iCloud(cloudAccessibility):
                return cloudAccessibility.accessibility
            }
            
        case .secureEnclave:
            return Accessibility.whenPasscodeSetThisDeviceOnly
        }
    }
}
