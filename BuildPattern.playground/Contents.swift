import Foundation

// MARK: - SignInDataSource
/// Defines the properties used in the builder.
protocol SignInDataSource {
    var email: String? { get }
    var password: String? { get }
    var facebookToken: String? { get }
    var googleToken: String? { get }
}

// MARK: - SignInProvider
/// Generic class used to  sign in object.
final class SignInProvider<T: SignInBuilderDataSource>: SignInDataSource {
    
    private var elementType: SignInBuilderDataSource.Type
    
    fileprivate(set) var email: String?
    fileprivate(set) var password: String?
    fileprivate(set) var facebookToken: String?
    fileprivate(set) var googleToken: String?
    
    var instance: T?
    
    init() {
        elementType = T.self
        instance = elementType.init() as? T
    }
}

// MARK: - SignInBuilderDataSource Protocol
/// Protocol that all generic SignInBuilder class should implement.
protocol SignInBuilderDataSource {
    init()
}

// MARK: - SignInBuilder
/// Builder class used to simplify sign in object creation.
final class SignInBuilder<T: SignInBuilderDataSource> {
    private var innerBuild = SignInProvider<T>()
    
    init() {
    }
    
    /// Setter for setting email.
    /// - Parameters:
    ///   - email: Email.
    /// - Returns: A `SignInBuilder`
    @discardableResult
    func setEmail(_ email: String) -> SignInBuilder {
        innerBuild.email = email
        return self
    }
    
    /// Setter for setting password.
    /// - Parameters:
    ///   - password: Password.
    /// - Returns: A `SignInBuilder`
    @discardableResult
    func setPassword(_ password: String) -> SignInBuilder {
        innerBuild.password = password
        return self
    }
    
    /// Setter for setting facebookToken.
    /// - Parameters:
    ///   - facebookToken: Facebook token.
    /// - Returns: A `SignInBuilder`
    @discardableResult
    func setFacebookToken(_ facebookToken: String) -> SignInBuilder {
        innerBuild.facebookToken = facebookToken
        return self
    }
    
    /// Setter for setting Google token.
    /// - Parameters:
    ///   - googleToken: Google token.
    /// - Returns: A `SignInBuilder`
    @discardableResult
    func setGoogleToken(_ googleToken: String) -> SignInBuilder {
        innerBuild.googleToken = googleToken
        return self
    }
    
    /// Build the instance.
    /// - Returns: A `SignInProvider<T>`
    func build() -> SignInProvider<T> {
        return innerBuild
    }
}

// MARK: - UserSignIn
final class UserSignIn: SignInBuilderDataSource {
    let session = URLSession.shared
    required init() {
    }
}

let userSignIn = SignInBuilder<UserSignIn>()
    .setEmail("test@host.com")
    .setPassword("test123")
    .build()

print(userSignIn.email)
print(userSignIn.password)
print(userSignIn.facebookToken)
print(userSignIn.googleToken)
print(userSignIn.instance?.session)

// MARK: - FacebookSignIn
final class FacebookSignIn: SignInBuilderDataSource {
    let apiKey = "some api key"
    required init() {
    }
}

let facebookSignIn = SignInBuilder<FacebookSignIn>()
    .setFacebookToken("2318120938jnjnkjnkda123123n8sa4qdas")
    .build()

print(facebookSignIn.email)
print(facebookSignIn.password)
print(facebookSignIn.facebookToken)
print(facebookSignIn.googleToken)
print(facebookSignIn.instance?.apiKey)

// MARK: - GoogleSignIn
final class GoogleSignIn: SignInBuilderDataSource {
    let apiKey = "some api key"
    let host = "https://google.com"
    
    required init() {
    }
}

let googleSignIn = SignInBuilder<GoogleSignIn>()
    .setGoogleToken("2318120938jnjnkjnkda123123n8sa4qdas")
    .build()

print(googleSignIn.email)
print(googleSignIn.password)
print(googleSignIn.facebookToken)
print(googleSignIn.googleToken)
print(googleSignIn.instance?.apiKey)
print(googleSignIn.instance?.host)
