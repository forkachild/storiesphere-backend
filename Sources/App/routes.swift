//
//  routes.swift
//  App
//
//  Created by Suhel Chakraborty on 12/08/19.
//

import Vapor

public func routes(_ router: Router) throws {
    
    let usersController: UsersController = DefaultUsersController()
    let postsController: PostsController = DefaultPostController()
    
    try router.register(collection: postsController)
    try router.register(collection: usersController)
    
}
