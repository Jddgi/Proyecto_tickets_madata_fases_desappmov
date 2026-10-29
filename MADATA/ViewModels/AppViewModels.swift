import Foundation
import Combine

class TicketsViewModel: ObservableObject {
    @Published var tickets: [TicketModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchTickets() {
        self.isLoading = true
        // Datos de respaldo simulados para asegurar el éxito del video de presentación del MVP
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tickets = [
                TicketModel(id: "1", title: "#TK-2026-001", description: "Problema de acceso al servidor", status: "En proceso", date: "12/08/2026"),
                TicketModel(id: "2", title: "#TK-2026-002", description: "Solicitud de respaldo de BD", status: "Abierto", date: "10/08/2026"),
                TicketModel(id: "3", title: "#TK-2026-003", description: "Error en conexión VPN", status: "Resuelto", date: "08/08/2026"),
                TicketModel(id: "4", title: "#TK-2026-004", description: "Consulta de licencias", status: "Cerrado", date: "05/08/2026")
            ]
            self.isLoading = false
        }
    }
}

struct TicketModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let status: String
    let date: String
}
