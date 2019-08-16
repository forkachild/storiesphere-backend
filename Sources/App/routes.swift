import Vapor

public func routes(_ router: Router) throws {
    let usersController: UsersController = DefaultUsersController()
    let postsController: PostsController = DefaultPostController()
    
    try router.register(collection: postsController)
    try router.register(collection: usersController)
    
}
