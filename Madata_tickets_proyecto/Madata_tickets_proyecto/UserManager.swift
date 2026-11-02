//
//  UserManager.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 15/10/26.
//

import Foundation

struct User: Codable {

    var nombre: String
    var apellido: String
    var empresa: String

    var email: String
    var password: String
}

class UserManager {

    static let shared = UserManager()

    private let key = "saved_users"

    func getUsers() -> [User] {

        if let data = UserDefaults.standard.data(forKey: key),
           let users = try? JSONDecoder().decode([User].self, from: data) {

            return users
        }

        return [

            User(
                nombre: "Administrador",
                apellido: "Sistema",
                empresa: "MADATA",
                email: "admin@madata.com",
                password: "admin123"
            ),

            User(
                nombre: "Cliente",
                apellido: "Demo",
                empresa: "MADATA",
                email: "cliente@madata.com",
                password: "123456"
            ),

            User(
                nombre: "Soporte",
                apellido: "Tecnico",
                empresa: "MADATA",
                email: "soporte@madata.com",
                password: "soporte123"
            ),

            User(
                nombre: "Juan",
                apellido: "Demo",
                empresa: "MADATA",
                email: "juan@madata.com",
                password: "juan123"
            )
        ]
    }

    func saveUsers(_ users: [User]) {

        if let data = try? JSONEncoder().encode(users) {

            UserDefaults.standard.set(
                data,
                forKey: key
            )
        }
    }

    func addUser(
        nombre: String,
        apellido: String,
        empresa: String,
        email: String,
        password: String
    ) {

        var users = getUsers()

        users.append(
            User(
                nombre: nombre,
                apellido: apellido,
                empresa: empresa,
                email: email,
                password: password
            )
        )

        saveUsers(users)
    }
}
