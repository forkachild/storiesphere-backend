//
//  migrations.swift
//  App
//
//  Created by Suhel Chakraborty on 12/08/19.
//

import FluentPostgreSQL

public func registerMigrations(_ migrations: inout MigrationConfig) {
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: TokenUser.self, database: .psql)
    migrations.add(model: Post.self, database: .psql)
}
