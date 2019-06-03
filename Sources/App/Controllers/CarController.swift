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
        tokenProtected.get("random", Int.parameter, use: getNRandomCars)
        
//        carsRoute.get("random", use: getRandomCars)
    }
    
    func getAllCars(_ req: Request) throws -> Car { //this is syncronous
         return CarElement.parseFromLocal()
    }
    
    func getRandomCars(_ req: Request) throws -> Car {
         var shuffledArray = CarElement.parseFromLocal()
         return shuffledArray.shuffle()
    }
    
    func getNRandomCars(_ req: Request) throws -> Car {
        var shuffledArray = CarElement.parseFromLocal()
        shuffledArray = shuffledArray.shuffle()
//        var slicedArray = shuffledArray.prefix(req.parameters.next(Int.self))
//        return try CarElement.parseFromLocal().choose(req.parameters.next(Int.self))
        return try Array(shuffledArray.prefix(req.parameters.next(Int.self)))
    }
}
