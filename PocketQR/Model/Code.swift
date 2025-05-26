//
//  ScannedQRCodes.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import Foundation

struct Code: Identifiable, Codable {
    
    //MARK: Stored proprties
    let id = UUID()
    let scanedData: String
    
}
