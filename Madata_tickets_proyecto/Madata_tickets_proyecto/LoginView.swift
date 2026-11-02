//
//  LoginView.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 30/09/26.
//

import SwiftUI

struct LoginView: View {

    @Binding var isLoggedIn: Bool

    @State private var email = ""
    @State private var password = ""

    @State private var showError = false
    @State private var errorMessage = ""

    @State private var showRegister = false

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Image(systemName: "server.rack")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)

                Text("MADATA")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Correo", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)

                SecureField("Contraseña", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button {

                    let users = UserManager.shared.getUsers()

                    if let user = users.first(where: { $0.email == email }) {

                        if user.password == password {

                            SessionManager.shared
                                .saveCurrentUser(user)

                            isLoggedIn = true
                        }else {

                            errorMessage = "Contraseña incorrecta."
                            showError = true
                        }

                    } else {

                        errorMessage = "El usuario no existe."
                        showError = true
                    }

                } label: {

                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button("Crear cuenta") {

                    showRegister = true
                }
                .sheet(isPresented: $showRegister) {

                    RegisterView()
                }

            }
            .padding()
            .navigationTitle("Login")
            .alert("Error de acceso",
                   isPresented: $showError) {

                Button("Aceptar") { }

            } message: {

                Text(errorMessage)
            }
        }
    }
}
