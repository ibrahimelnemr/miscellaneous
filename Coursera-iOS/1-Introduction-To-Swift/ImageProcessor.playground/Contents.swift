//: Playground - noun: a place where people can play

import UIKit


let sampleImage = UIImage(named: "sample")!

var RGBAImage1 = RGBAImage(image: sampleImage)!
var RGBAImage2 = RGBAImage(image: sampleImage)!

enum FilterType: String {
    case brightness = "Brightness"
    case contrast = "Contrast"
}

class Filter {
    let type: FilterType
    let strength: Int

    init(type: FilterType, strength: Int) {
        self.type = type
        self.strength = strength
    }

    func apply(inout to pixels: [Pixel]) {
        switch type {
        case .brightness:
            applyBrightness(to: &pixels)
        case .contrast:
            applyContrast(to: &pixels)
        }
    }

    private func applyBrightness(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }

    private func applyContrast(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }

    private func applyFormula(value: UInt8) -> UInt8 {
        let newValue = Int(value) + strength
        return UInt8(max(0, min(255, newValue)))
    }
}

class ImageProcessorTest {
    var filters: [Filter] = []

    init() {
        filters = [
            Filter(type: .brightness, strength: 50),
            Filter(type: .contrast, strength: 2)
        ]
    }

    func applyFilters(inout to myRGBA: RGBAImage) {
        for filter in filters {
            filter.apply(to: &myRGBA.pixels)
        }
    }

    func applyFilterByName(inout to myRGBA: RGBAImage, filterName: String) {
        if let filter = filters.first where filter.type.rawValue == filterName {
            filter.apply(to: &myRGBA.pixels)
        } else {
            print("Filter '\(filterName)' not found")
        }
    }
    
    func applyFiltersByName(inout to myRGBA: RGBAImage, filterNames: [String]) {
        for filterName in filterNames {
            if let filter = filters.first where filter.type.rawValue == filterName {
                filter.apply(to: &myRGBA.pixels)
            } else {
                print("Filter '\(filterName)' not found")
            }
        }
    }
}


class ImageProcessor {
    init() {
        
    }
    
    
    
    func applyFilter(inout to myRGBA: RGBAImage, filterStrength: Int, filterColor: String) {
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


let processor = ImageProcessor()
let testProcessor = ImageProcessorTest()

processor.applyFilter(to: &RGBAImage1, filterStrength: 10, filterColor: "Red")

let processedImage = RGBAImage1.toUIImage()


testProcessor.applyFilters(to: &RGBAImage2)

let processedImageTest = RGBAImage2.toUIImage()

testProcessor.applyFilterByName(to: &RGBAImage2, filterName: "Contrast")

let filterNames = ["Brightness", "Contrast"]

testProcessor.applyFiltersByName(to: &RGBAImage2, filterNames: filterNames)

let processedImageTest2 = RGBAImage2.toUIImage()
