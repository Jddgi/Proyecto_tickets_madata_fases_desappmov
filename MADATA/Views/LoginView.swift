import SwiftUI

struct LoginView:View {
    @EnvironmentObject var session:SessionStore
    @State private var email="demo@madata.mx"; @State private var password="Demo1234!"; @State private var error=""; @State private var loading=false; @State private var showRegister=false
    var body:some View { NavigationStack { VStack(spacing:20) {
        Spacer(); Image(systemName:"server.rack").font(.system(size:58)).foregroundStyle(.cyan)
        Text("MADATA").font(.largeTitle.bold()); Text("Monitoreo y soporte empresarial").foregroundStyle(.secondary)
        TextField("Correo",text:$email).textInputAutocapitalization(.never).keyboardType(.emailAddress).textFieldStyle(.roundedBorder)
        SecureField("Contraseña",text:$password).textFieldStyle(.roundedBorder)
        if !error.isEmpty { Text(error).foregroundStyle(.red).font(.caption) }
        Button { Task { loading=true; defer{loading=false}; do { try await session.signIn(email:email,password:password) } catch { self.error=error.localizedDescription } } } label:{ if loading { ProgressView() } else { Text("Iniciar sesión").frame(maxWidth:.infinity) } }.buttonStyle(.borderedProminent).disabled(email.isEmpty||password.isEmpty||loading)
        Button("Crear cuenta") { showRegister=true }
        Spacer()
    }.padding().navigationDestination(isPresented:$showRegister){ RegisterView() } } }
}

struct RegisterView:View {
    @EnvironmentObject var session:SessionStore; @Environment(\.dismiss) var dismiss
    @State private var name="",email="",password="",phone="",company="MADATA Cliente"; @State private var message=""
    var body:some View { Form { Section("Datos") { TextField("Nombre",text:$name); TextField("Correo",text:$email).textInputAutocapitalization(.never); SecureField("Contraseña",text:$password); TextField("Teléfono",text:$phone); TextField("Empresa",text:$company) }
        if !message.isEmpty { Text(message) }
        Button("Registrarse") { Task { do { try await session.register(name:name,email:email,password:password,phone:phone,company:company); message="Cuenta creada. Ya puedes iniciar sesión." } catch { message=error.localizedDescription } } }.disabled(name.isEmpty||email.isEmpty||password.count<8)
    }.navigationTitle("Crear cuenta") }
}
