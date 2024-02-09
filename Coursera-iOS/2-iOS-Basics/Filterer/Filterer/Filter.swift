//Filter.swift
import UIKit


let sampleImage = UIImage(named: "sample")!

var RGBAImage1 = RGBAImage(image: sampleImage)!
var RGBAImage2 = RGBAImage(image: sampleImage)!

enum FilterType: String {
    case brightness = "Brightness"
    case contrast = "Contrast"
}

public class Filter {
    let type: FilterType
    let strength: Int

    init(type: FilterType, strength: Int) {
        self.type = type
        self.strength = strength
    }

    static func apply(inout to pixels: [Pixel]) {
        switch type {
        case .brightness:
            applyBrightness(to: &pixels)
        case .contrast:
            applyContrast(to: &pixels)
        }
    }

    static private func applyBrightness(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }

    static private func applyContrast(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }

    static private func applyFormula(value: UInt8) -> UInt8 {
        let newValue = Int(value) + strength
        return UInt8(max(0, min(255, newValue)))
    }
}

class ImageProcessorTest {
    var filters: [Filter] = [
            Filter(type: .brightness, strength: 50),
            Filter(type: .contrast, strength: 2)
        ]

    init() {
        
    }

    static func applyFilters(inout to myRGBA: RGBAImage) {
        for filter in filters {
            filter.apply(to: &myRGBA.pixels)
        }
    }

    static func applyFilterByName(inout to myRGBA: RGBAImage, filterName: String) {
        if let filter = filters.first where filter.type.rawValue == filterName {
            filter.apply(to: &myRGBA.pixels)
        } else {
            print("Filter '\(filterName)' not found")
        }
    }
    
    static func applyFiltersByName(inout to myRGBA: RGBAImage, filterNames: [String]) {
        for filterName in filterNames {
            if let filter = filters.first where filter.type.rawValue == filterName {
                filter.apply(to: &myRGBA.pixels)
            } else {
                print("Filter '\(filterName)' not found")
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
