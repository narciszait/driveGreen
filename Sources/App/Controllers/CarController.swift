import Vapor
import Crypto

final class CarController: RouteCollection {

    func boot(router: Router) throws {
        let carsRoute = router.grouped("api", "cars")
        
        let basicAuthMiddleware = User.basicAuthMiddleware(using: BCryptDigest())
        let guardAuthMiddleware = User.guardAuthMiddleware()
        
        let basicProtected = carsRoute.grouped(basicAuthMiddleware, guardAuthMiddleware)
        
        let tokenAuthMiddleware = User.tokenAuthMiddleware()
        let tokenProtected = carsRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenProtected.get(use: getAllCars)
        tokenProtected.get("random", use: getRandomCars)
        
//        carsRoute.get("random", use: getRandomCars)
    }
    
    func getAllCars(_ req: Request) throws -> Car { //this is syncronous
//        let directory = DirectoryConfig.detect()
//        let configDir = "Sources/App/Models"
//
//       let data = try Data(contentsOf: URL(fileURLWithPath: directory.workDir)
//                .appendingPathComponent(configDir, isDirectory: true)
//                .appendingPathComponent("carsJSON.json", isDirectory: false))
//
//        return try JSONDecoder().decode(Car.self, from: data)
        
         return CarElement.parseFromLocal()
    }
    
    func getRandomCars(_ req: Request) throws -> Car {
//        let directory = DirectoryConfig.detect()
//        let configDir = "Sources/App/Models"
//
//        let data = try Data(contentsOf: URL(fileURLWithPath: directory.workDir)
//            .appendingPathComponent(configDir, isDirectory: true)
//            .appendingPathComponent("carsJSON.json", isDirectory: false))
//
//        let carArray = try JSONDecoder().decode(Car.self, from: data)
//
//        return carArray.choose(10)
        
         return CarElement.parseFromLocal().choose(10)
    }
}
