import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            DashboardView()
                .tabItem {
                    Label(
                        "Inicio",
                        systemImage: "house"
                    )
                }

            MonitoringView()
                .tabItem {
                    Label(
                        "Monitoreo",
                        systemImage: "server.rack"
                    )
                }

            TicketsView()
                .tabItem {
                    Label(
                        "Tickets",
                        systemImage: "ticket"
                    )
                }

            ProfileView()
                .tabItem {
                    Label(
                        "Perfil",
                        systemImage: "person"
                    )
                }
        }
    }
}
