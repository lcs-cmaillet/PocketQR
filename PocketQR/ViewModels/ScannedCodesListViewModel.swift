//
//  QRCodeList.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import Foundation

@Observable @MainActor
class ScannedCodesListViewModel: Observable {
    
    //MARK: Stored properties
    
    //List QR codes, stored in the order they were added in the array
    //NOTE: Pre-populated with example QRs from model
    var scannedCodes: [Code] = []
    
    //MARK: Function(s)
    
    // 1. Add a code
    func add(newCode: scannedCodes) {
        
        //Append the provided QRs to the list of tracked QRs
        self.scannedCodes.append(newCode)
    }
}

