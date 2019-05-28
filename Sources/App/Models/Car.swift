//
//  Car.swift
//  App
//
//  Created by Narcis Zait on 27/05/2019.
//

import Foundation
import Vapor

typealias Car = [CarElement]

final class CarElement: Codable { //NSObject, Codable, NSCoding
    let latitude, longitude, batteryPercentage, interestInTheCar: String
    let field5: Field5
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case batteryPercentage = "Battery percentage"
        case interestInTheCar = "Interest in the car"
        case field5
    }
    
    init(latitude: String, longitude: String, batteryPercentage: String, interestInTheCar: String, field5: Field5) {
        self.latitude = latitude
        self.longitude = longitude
        self.batteryPercentage = batteryPercentage
        self.interestInTheCar = interestInTheCar
        self.field5 = field5
    }
    
    func parseFromLocal(){
        let directory = DirectoryConfig.detect()
        let configDir = "Sources/App/Models"
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: directory.workDir)
                .appendingPathComponent(configDir, isDirectory: true)
                .appendingPathComponent("carsJSON.json", isDirectory: false))
            
            print("cardata \(data)")
            
            // continue processing
            
        } catch {
            print(error)
        }
    }
}

enum Field5: String, Codable {
    case field5Good = "Good"
    case good = "good"
}

extension CarElement: Content {}
//extension CarElement: Parameter {}

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    
    var chooseOne: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
        
    }
    
    func choose(_ n: Int) -> Array {
        return Array(shuffled.prefix(n))
    }
}