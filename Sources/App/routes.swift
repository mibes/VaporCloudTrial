import Vapor

extension QueryContainer {
    func getString(param: String) -> String? {
        do {
            let result = try self.get(String.self, at: param)
            return result
        } catch {
            return nil
        }
    }
}


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req -> String in
        if let name = req.query.getString(param: "user") {
            return "Hello, \(name)!"
        } else {
            return "Hello, World!"
        }
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
