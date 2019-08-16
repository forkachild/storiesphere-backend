import FluentPostgreSQL

public func registerMigrations(_ migrations: inout MigrationConfig) {
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: TokenUser.self, database: .psql)
    migrations.add(model: Post.self, database: .psql)
}
