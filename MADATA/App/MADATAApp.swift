import SwiftUI

@main
struct MADATAApp: App {
    @StateObject private var session = SessionStore()
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(session)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        Group {
            if session.user == nil { LoginView() }
            else { MainTabView() }
        }
    }
}
