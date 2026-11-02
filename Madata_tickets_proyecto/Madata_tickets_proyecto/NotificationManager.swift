//
//  NotificationManager.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 01/10/26.
//

import Foundation

struct AppNotification: Codable, Identifiable {

    var id = UUID()

    var mensaje: String

    var fecha: String

    var usuarioEmail: String
}

class NotificationManager {

    static let shared = NotificationManager()

    private let key = "saved_notifications"

    func getNotifications() -> [AppNotification] {

        if let data = UserDefaults.standard.data(
            forKey: key
        ),
        let notifications = try? JSONDecoder()
            .decode(
                [AppNotification].self,
                from: data
            ) {

            return notifications
        }

        return []
    }

    func getNotificationsForCurrentUser()
    -> [AppNotification] {

        guard let usuario =
            SessionManager.shared
                .getCurrentUser()
        else {

            return []
        }

        return getNotifications()
            .filter {

                $0.usuarioEmail ==
                usuario.email
            }
    }

    func addNotification(
        _ mensaje: String
    ) {

        guard let usuario =
            SessionManager.shared
                .getCurrentUser()
        else {

            return
        }

        var notificaciones =
            getNotifications()

        let formatter =
            DateFormatter()

        formatter.dateFormat =
            "dd/MM/yyyy HH:mm"

        let notification =
            AppNotification(
                mensaje: mensaje,
                fecha: formatter.string(
                    from: Date()
                ),
                usuarioEmail:
                    usuario.email
            )

        notificaciones.insert(
            notification,
            at: 0
        )

        if let data = try? JSONEncoder()
            .encode(notificaciones) {

            UserDefaults.standard.set(
                data,
                forKey: key
            )
        }
    }
}
