import Vapor


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
//    let directory = DirectoryConfig.detect()
//    let configDir = "Sources/App/Models"
//    let data = try Data(contentsOf: URL(fileURLWithPath: directory.workDir)
//                    .appendingPathComponent(configDir, isDirectory: true)
//                    .appendingPathComponent("carsJSON.json", isDirectory: false))
//    let url = URL(fileURLWithPath: directory.workDir).appendingPathComponent(configDir, isDirectory: true).appendingPathComponent("carsJSON.json", isDirectory: false)
//
//
//    router.get("api", "cars") { req -> Request in
//         return req.fileio().read
//
//    }
    
    let usersController = UserController()
    try router.register(collection: usersController)
    
    let carController = CarController()
    try router.register(collection: carController)
}


