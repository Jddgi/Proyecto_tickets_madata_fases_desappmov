//
//  ProfileView.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 01/10/26.
//

import SwiftUI

struct ProfileView: View {

    @AppStorage("isLoggedIn")
    private var isLoggedIn = true

    let user =
        SessionManager.shared.getCurrentUser()

    var body: some View {

        List {

            Section("Usuario") {

                Text(
                    "\(user?.nombre ?? "") \(user?.apellido ?? "")"
                )

                Text(
                    user?.email ?? ""
                )
            }

            Section("Empresa") {

                Text(
                    user?.empresa ?? ""
                )
            }

            Section("Sesión") {

                Button(
                    "Cerrar sesión",
                    role: .destructive
                ) {

                    SessionManager.shared.logout()

                    isLoggedIn = false
                }
            }
        }
        .navigationTitle("Perfil")
    }
}
