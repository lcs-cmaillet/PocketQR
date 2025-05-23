//
//  ScannedCodesListView.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import CodeScanner
import SwiftUI

struct ScannedCodesListView: View {
    
    // Establish a connect to the view model
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                Text("Scanned value was:")
                    .bold()
                Text("\(code)")
                
                // 3. Show a scrollable list of scanned code
            } else {
                ContentUnavailableView("Nothing scanned yet", systemImage: "questionmark", description: Text("Please scan a code to get started"))
            }

            Button("Scan Code") {
                isPresentingScanner = true
            }

            Text("Scan a QR code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    isPresentingScanner = false
                    
                    // 2. Add a new QR code (call the function on the view model)
                }
            }
        }
    }
}

#Preview {
    ScannedCodesListView()
}
