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
    var scannedCodes: [Code] = [] {
        didSet {save()}
    }
    init() {
        load()
    }
    
    //MARK: Function(s)
    
    // 1. Add a code
    func add(newCode: Code) {
        
        print("About to add code \(newCode.scanedData) to array.")
        //Append the provided QRs to the list of tracked QRs
        self.scannedCodes.append(newCode)
        print("Aded code to array.")
    }
    private func getDocumentsDirectory() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
    }
    private let fileName = "scannedCodes.json"

    private func save() {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(scannedCodes)
            try data.write(to: url, options: .atomic)
            print("✅ Saved \(scannedCodes.count) codes.")
        } catch {
            print("⚠️ Save failed:", error)
        }
    }

    private func load() {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: url) else {
            print("ℹ️ No saved file found.")
            return
        }
        do {
            scannedCodes = try JSONDecoder().decode([Code].self, from: data)
            print("✅ Loaded \(scannedCodes.count) codes.")
        } catch {
            print("⚠️ Load failed:", error)
        }
    }

}

