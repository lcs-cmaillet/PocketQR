//
//  ScannedCodesListView.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import CodeScanner
import SwiftUI

struct ScannedCodesListView: View {
    
    // Establish a connection to the view model
    @State var viewModel = ScannedCodesListViewModel()
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                if let code = scannedCode {
                    
                    // 3. Show a scrollable list of scanned codes
                    List(viewModel.scannedCodes) { currentCode in
                        NavigationLink {
                            QRCodeView(providedString: currentCode.scanedData)
                        } label: {
                            Text(currentCode.scanedData)
                        }

                        
                    }
                } else {
                    ContentUnavailableView("Nothing scanned yet", systemImage: "questionmark", description: Text("Please scan a code to get started"))
                }

                Button("Scan Code") {
                    isPresentingScanner = true
                }

                Text("Scan a QR code to begin")
            }
            .navigationTitle("Pocket QR")
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        scannedCode = result.string
                        isPresentingScanner = false
                        
                        // 2. Add a new QR code (call the function on the view model)
                        viewModel.add(newCode: Code(scanedData: result.string))
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ScannedCodesListView()
}
