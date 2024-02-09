//ImageProcessor.swift
import Filter

public class ImageProcessor {
    init() {
        
    }
    
    
    
    static func applyFilter(inout to myRGBA: RGBAImage, filterStrength: Int, filterColor: String) {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0

        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        

        let count = myRGBA.width * myRGBA.height
        let avgRed = totalRed/count
        let avgGreen = totalGreen/count
        let avgBlue = totalBlue/count

        
        let acceptedColors = [
            "Green",
            "Red",
            "Blue"
        ]
        
        let acceptedStrengths = [1,2,3,4,5,6,7,8,9,10]
        
        if !acceptedColors.contains(filterColor) || !acceptedStrengths.contains(filterStrength) {
            print("Invalid filter or strength value")
            return
        }

        
        if filterColor == "Red" {
            
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let redDiff = Int(pixel.red) - avgRed
                    if (redDiff > 0) {
                        pixel.red = UInt8(max(0, min(255, avgRed + redDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }

        }
        else if filterColor == "Blue" {
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let redDiff = Int(pixel.red) - avgRed
                    if (redDiff > 0) {
                        pixel.red = UInt8(max(0, min(255, avgRed + redDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }

            
        }
        else if filterColor == "Green" {
            
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let redDiff = Int(pixel.red) - avgRed
                    if (redDiff > 0) {
                        pixel.red = UInt8(max(0, min(255, avgRed + redDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }
            
        }
     
    }
}