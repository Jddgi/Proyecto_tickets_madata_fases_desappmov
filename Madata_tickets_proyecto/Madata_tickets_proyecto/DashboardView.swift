//
//  DashboardView.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 31/09/26.
//

import SwiftUI

struct DashboardView: View {

    @State private var refreshID = UUID()

    var misTickets: [Ticket] {

        guard let usuario =
            SessionManager.shared.getCurrentUser()
        else {

            return []
        }

        return TicketManager.shared
            .getTickets()
            .filter {
                $0.usuarioEmail ==
                usuario.email
            }
    }

    var ticketsAbiertos: Int {

        misTickets.filter {
            $0.estado == "Abierto"
        }.count
    }

    var ticketsCerrados: Int {

        misTickets.filter {
            $0.estado == "Cerrado"
        }.count
    }

    var ticketsEnAtencion: Int {

        misTickets.filter {
            $0.estado == "En Atención"
        }.count
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {

                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()

                    DashboardCard(
                        title: "Tickets Totales",
                        value: "\(misTickets.count)",
                        color: .blue
                    )

                    DashboardCard(
                        title: "Tickets Cerrados",
                        value: "\(ticketsCerrados)",
                        color: .green
                    )

                    DashboardCard(
                        title: "Tickets Abiertos",
                        value: "\(ticketsAbiertos)",
                        color: .orange
                    )

                    DashboardCard(
                        title: "Tickets En Atención",
                        value: "\(ticketsEnAtencion)",
                        color: .purple
                    )

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text("Notificaciones")
                            .font(.title2)
                            .bold()

                        ForEach(
                            NotificationManager
                                .shared
                                .getNotificationsForCurrentUser()
                                .prefix(10)
                        ) { notification in

                            NotificationCard(
                                icon: "bell.fill",
                                text:
                                    notification.mensaje
                                    + " - "
                                    + notification.fecha
                            )
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
            .id(refreshID)
            .navigationTitle("Inicio")
            .toolbar {

                Button {

                    refreshID = UUID()

                } label: {

                    Image(
                        systemName: "arrow.clockwise"
                    )
                }
            }
        }
    }
}

struct DashboardCard: View {

    let title: String
    let value: String
    let color: Color

    var body: some View {

        VStack(spacing: 10) {

            Text(value)
                .font(.system(size: 42))
                .bold()

            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.2))
        .cornerRadius(15)
    }
}

struct NotificationCard: View {

    let icon: String
    let text: String

    var body: some View {

        HStack {

            Image(systemName: icon)
                .foregroundColor(.blue)

            Text(text)

            Spacer()
        }
        .padding()
        .background(
            Color.gray.opacity(0.1)
        )
        .cornerRadius(12)
    }
}
