import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    
    let helper = JWTHelper()
    
    router.get("hello") { req -> String in
        do {
            let user = try req.query.get(String.self, at: "user")
            let role = try req.query.get(String.self, at: "role")

            if let jwt = helper.sign(name: user, role: role) {
                return "Hello, \(user)! Your key is: \(jwt)"
            } else {
                return "Hello, \(user)! Thanks for being our: \(role)"
            }
        } catch {
            return "Hello, World!"
        }
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
