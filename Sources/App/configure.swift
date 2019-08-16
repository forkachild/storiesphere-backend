import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    try registerServices(&config, &env, &services)
    try registerRoutes(&config, &env, &services)
    try registerMiddleware(&config, &env, &services)
    try registerDatabaseWithMigrations(&config, &env, &services)
//    try registerContentConfig(&config, &env, &services)
    
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
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
//    middlewares.use(ErrorMiddleware.self)
    middlewares.use(ResponseFormatterMiddleware.self)
    services.register(middlewares)
}

fileprivate func registerDatabaseWithMigrations(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    let postgresql = PostgreSQLDatabase(config: PostgreSQLDatabaseConfig(url: "postgres://qrbwaaavwaawca:4da672db9f9e8cfb9ef6a8a659da33754b2ec771e4ba9d984baf141e9ea48331@ec2-54-217-234-157.eu-west-1.compute.amazonaws.com:5432/d7vjbrh928fmdo", transport: .unverifiedTLS)!)
    
    var databases = DatabasesConfig()
    databases.add(database: postgresql, as: .psql)
    services.register(databases)
    
    var migrations = MigrationConfig()
    registerMigrations(&migrations)
    services.register(migrations)
}

//fileprivate func registerContentConfig(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
//    var content = ContentConfig.default()
//    let encoder = JSONEncoder()
//    encoder.keyEncodingStrategy = .convertToSnakeCase
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//    content.use(encoder: encoder, for: .json)
//    content.use(decoder: decoder, for: .json)
//
//    services.register(content)
//}
