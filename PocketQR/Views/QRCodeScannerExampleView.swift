//
//  QRCodeScannerExampleView.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import CodeScanner
import SwiftUI

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                Text("Scanned value was:")
                    .bold()
                Text("\(code)")
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
                }
            }
        }
    }
}
