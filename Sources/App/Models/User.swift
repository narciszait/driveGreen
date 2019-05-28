import Vapor
import FluentSQLite
import Authentication


final class User: Codable {
    var id: Int?
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    final class Public: Codable {
        var id: Int?
        var email: String
        
        init(id: Int?, email: String) {
            self.id = id
            self.email = email
        }
    }
}

extension User: SQLiteModel { }

extension User: Migration {
    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return Database.create(self, on: conn, closure: { (builder) in
            try addProperties(to: builder)
            builder.unique(on: \.email) //this should not allow duplicates in the db
        })
    }
}

extension User: Content { }
extension User.Public: Content { }

extension User: Parameter { }

extension User {
    //this is used to not return the hashed password
    func toPublic() -> User.Public {
        return User.Public(id: id, email: email)
    }
}

extension Future where T: User {
    func toPublic() -> Future<User.Public> {
        return map(to: User.Public.self) { (user) in
            return user.toPublic()
        }
    }
}

extension User: BasicAuthenticatable {    
    static var usernameKey: UsernameKey {
        return \User.email
    }
    
    static var passwordKey: PasswordKey {
        return \User.password
    }
}

struct AdminUser: Migration {
    typealias Database = SQLiteDatabase
    
    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        let password = try? BCrypt.hash("narcis16") // not recommended anywhere to do this, but i need an admin user
        guard let hashedPassword = password else {
            fatalError("Failed to create admin user")
        }
        
        let user = User(email: "narcis@drivegreen.com", password: hashedPassword)
        return user.save(on: conn).transform(to: ())
    }
    
    static func revert(on conn: SQLiteConnection) -> Future<Void> {
        return .done(on: conn)
    }
}

//1    narcis@drivegreen.com    $2y$12$eRl1lJgSjRrpxBw.ezFgDOlaIPnL72VLav/JQlD19CPyDEInaeJVq

extension User: TokenAuthenticatable {
    typealias TokenType = Token
}



