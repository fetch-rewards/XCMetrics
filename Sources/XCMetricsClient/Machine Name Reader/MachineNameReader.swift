// Copyright (c) 2020 Spotify AB.
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import Foundation

/// Reads the name of the machine where this command is executed
protocol MachineNameReader {
    var machineName: String? { get }
}

/// Implementation of `MachineReader` that uses the name of the host as the Machine name
class HashedMacOSMachineNameReader: MachineNameReader {

    let encrypted: Bool

    init(encrypted: Bool = true) {
        self.encrypted = encrypted
    }
    var machineName: String? {

        if encrypted {
            return Host.current().localizedName?.md5()
        }
        return removeLocalizedSingleQuotesAndSpaces(from: Host.current().localizedName)
    }

    func removeLocalizedSingleQuotesAndSpaces(from input: String) -> String {
        let allowedChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return String(inputString.filter { allowedChars.contains($0) })
    }
}


// import XCTest

// class StringSanitizationTests: XCTestCase {

//     func testRemoveLocalizedSingleQuotesAndSpaces() {
//         // Given
//         let inputString = "This is a ‘string’ with ’localized’ variations of `single quotes’."
        
//         // When
//         let sanitized = removeLocalizedSingleQuotesAndSpaces(from: inputString)
        
//         // Then
//         XCTAssertEqual(sanitized, "Thisisastringwithlocalizedvariationsofsinglequotes.")
//     }
    
// }

// // Run the tests
// StringSanitizationTests.defaultTestSuite.run()
