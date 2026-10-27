import Foundation

@MainActor final class SessionStore: ObservableObject {
    @Published var user:User?; @Published var token:String?
    func signIn(email:String,password:String) async throws {
        let response:AuthResponse=try await APIClient.shared.send("auth/login.php",method:"POST",body:["email":email,"password":password])
        guard response.success, let user=response.user else { throw APIError.server(response.message) }
        self.user=user; self.token=response.token
    }
    func register(name:String,email:String,password:String,phone:String,company:String) async throws {
        let response:AuthResponse=try await APIClient.shared.send("auth/register.php",method:"POST",body:["name":name,"email":email,"password":password,"phone":phone,"company":company])
        guard response.success else { throw APIError.server(response.message) }
    }
    func signOut(){ user=nil; token=nil }
}
