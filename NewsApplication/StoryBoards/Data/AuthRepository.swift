
import FirebaseAuth

class AuthRepository {
    func saveUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let success = error.isNil()
            completion(success)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            let success = error.isNil()
            completion(success)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("An error occurred while logging out: \(signOutError.localizedDescription)")
        }
    }
    
    public func getCurrentUser() -> User? {
        Auth.auth().currentUser
    }
}
