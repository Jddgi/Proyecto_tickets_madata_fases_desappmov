import SwiftUI
struct ServicesView:View {
    @EnvironmentObject var session:SessionStore; @StateObject private var vm=ServiceViewModel()
    var body:some View { List(vm.services){s in VStack(alignment:.leading,spacing:6){HStack{Text(s.name).bold();Spacer();Text(s.status).font(.caption).foregroundStyle(.green)};Text(s.details).font(.subheadline);if let date=s.validUntil{Text("Vigencia: \(date)").font(.caption).foregroundStyle(.secondary)}} }.navigationTitle("Servicios").task{if let id=session.user?.id{await vm.load(userId:id)}} }
}
