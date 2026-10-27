import SwiftUI

struct TicketsView:View {
    @EnvironmentObject var session:SessionStore; @StateObject private var vm=TicketViewModel(); @State private var creating=false
    var body:some View { Group { if vm.isLoading { ProgressView() } else { List(vm.tickets){t in VStack(alignment:.leading,spacing:6){HStack{Text(t.title).bold();Spacer();Text(t.priority.rawValue.capitalized).font(.caption).padding(5).background(.orange.opacity(0.2),in:Capsule())};Text(t.details).font(.subheadline);Text(t.status.rawValue.replacingOccurrences(of:"_",with:" ").capitalized).font(.caption).foregroundStyle(.secondary)} } } }
        .navigationTitle("Tickets").toolbar{Button{creating=true}label:{Image(systemName:"plus")}}.sheet(isPresented:$creating){CreateTicketView(vm:vm)}
        .task{if let id=session.user?.id{await vm.load(userId:id)}}.alert("Error",isPresented:.constant(!vm.errorMessage.isEmpty)){Button("OK"){vm.errorMessage=""}}message:{Text(vm.errorMessage)}
    }
}
struct CreateTicketView:View {
    @EnvironmentObject var session:SessionStore; @Environment(\.dismiss) var dismiss; @ObservedObject var vm:TicketViewModel
    @State private var title="",details="",priority:TicketPriority = .media; @State private var error=""
    var body:some View { NavigationStack { Form { TextField("Título",text:$title);TextField("Descripción",text:$details,axis:.vertical).lineLimit(4...8);Picker("Prioridad",selection:$priority){ForEach(TicketPriority.allCases){Text($0.rawValue.capitalized).tag($0)}};if !error.isEmpty{Text(error).foregroundStyle(.red)} }
        .navigationTitle("Nuevo ticket").toolbar{ToolbarItem(placement:.cancellationAction){Button("Cancelar"){dismiss()}};ToolbarItem(placement:.confirmationAction){Button("Guardar"){Task{do{try await vm.create(userId:session.user!.id,title:title,details:details,priority:priority);dismiss()}catch{self.error=error.localizedDescription}}}.disabled(title.isEmpty||details.isEmpty)}} }
    }
}
