import FluentPostgreSQL
import Vapor

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try registerServices(&config, &env, &services)
    try registerRoutes(&config, &env, &services)
    try registerMiddleware(&config, &env, &services)
    try registerDatabaseWithMigrations(&config, &env, &services)
}

fileprivate func registerServices(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(FluentPostgreSQLProvider())
    services.register(AuthUserMiddleware.self)
    services.register(ResponseFormatterMiddleware.self)
    services.register(DefaultImageUploadService(), as: ImageUploadService.self)
}

fileprivate func registerRoutes(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
}

fileprivate func registerMiddleware(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    var middlewares = MiddlewareConfig()
    middlewares.use(ResponseFormatterMiddleware.self)
    services.register(middlewares)
}

fileprivate func registerDatabaseWithMigrations(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    let postgresql = PostgreSQLDatabase(config: PostgreSQLDatabaseConfig(url: Constants.databaseUrl,
                                                                         transport: .unverifiedTLS)!)
    
    var databases = DatabasesConfig()
    databases.add(database: postgresql, as: .psql)
    services.register(databases)
    
    var migrations = MigrationConfig()
    registerMigrations(&migrations)
    services.register(migrations)
}
