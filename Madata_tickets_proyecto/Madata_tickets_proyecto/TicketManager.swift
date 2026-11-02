//
//  TicketManager.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 15/10/26.
//

import Foundation

struct Ticket: Codable, Identifiable {

    var id = UUID()

    var folio: String
    var titulo: String
    var categoria: String
    var prioridad: String
    var descripcion: String

    var fecha: String
    var estado: String

    var usuarioEmail: String
}

class TicketManager {

    static let shared = TicketManager()

    private let key = "saved_tickets"

    func getTickets() -> [Ticket] {

        if let data = UserDefaults.standard.data(forKey: key),
           let tickets = try? JSONDecoder().decode([Ticket].self, from: data) {

            return tickets
        }

        return []
    }

    func saveTickets(_ tickets: [Ticket]) {

        if let data = try? JSONEncoder().encode(tickets) {

            UserDefaults.standard.set(
                data,
                forKey: key
            )
        }
    }

    func addTicket(_ ticket: Ticket) {

        var tickets = getTickets()

        tickets.append(ticket)

        saveTickets(tickets)
    }

    func updateTicket(_ updatedTicket: Ticket) {

        var tickets = getTickets()

        print("Buscando ticket: \(updatedTicket.folio)")

        if let index = tickets.firstIndex(
            where: { $0.folio == updatedTicket.folio }
        ) {

            tickets[index] = updatedTicket

            saveTickets(tickets)

            print("Ticket actualizado correctamente")

        } else {

            print("NO SE ENCONTRO EL TICKET")
        }
    }
}
