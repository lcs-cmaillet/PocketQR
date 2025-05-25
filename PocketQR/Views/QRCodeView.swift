//
//  QRCodeView.swift
//  QRCodeExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import SwiftUI

// NOTE: Based on example given here:
//       https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code

// NOTE: Issue with interpolation resolved by enlarging image at the Core Graphics stage
//       Adapted from:
//       https://www.avanderlee.com/swift/qr-code-generation-swift/

import CoreImage.CIFilterBuiltins
import OSLog
import SwiftUI

struct QRCodeView: View {
    
    let providedString: String
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            Image(uiImage: generateQRCode(from: providedString))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.horizontal)
            
            VStack(alignment: .center, spacing: 0) {
                
                Text(providedString)
                    .font(.body)
                    .multilineTextAlignment(.center)

            }
            .padding(.horizontal, 5)
            
            Spacer()
            
        }
        .padding(.top, 10)
        .frame(width: 110, height: 175)
    }
    
    func generateQRCode(from string: String) -> UIImage {
        
        // Make a raw byte buffer from the provided string
        filter.message = Data(string.utf8)
        
        // Attempt to generate an output image that is a QR code (see configuration of filter above)
        if let outputImage = filter.outputImage {
            
            // Enlarge the image (thank-you, Antoine van der Lee)
            let embiggeningTransform = CGAffineTransform(scaleX: 20, y: 20)
            let largerOutputImage = outputImage.transformed(by: embiggeningTransform)
            
            // Attempt to create a Quartz 2D image from the Core Image image object
            if let cgImage = context.createCGImage(largerOutputImage, from: largerOutputImage.extent) {
                
                // Now attempt to create an instance of UIImage
                return UIImage(cgImage: cgImage, scale: 400, orientation: .up)
            }
        }
        
        // If the conversion fails for any reason we will return to "xmark.circle" image from SF Symbols
        return UIImage(systemName: "xmark.circle")!
    }
}


#Preview {
    QRCodeView(providedString: "Collin Maillet")
    .padding()
}
