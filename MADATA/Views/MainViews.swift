import SwiftUI

struct MainTabView:View { var body:some View { TabView {
    NavigationStack{DashboardView()}.tabItem{Label("Inicio",systemImage:"square.grid.2x2")}
    NavigationStack{MonitoringView()}.tabItem{Label("Monitoreo",systemImage:"server.rack")}
    NavigationStack{TicketsView()}.tabItem{Label("Tickets",systemImage:"ticket")}
    NavigationStack{ServicesView()}.tabItem{Label("Servicios",systemImage:"shippingbox")}
    NavigationStack{ProfileView()}.tabItem{Label("Perfil",systemImage:"person")}
} } }

struct DashboardView:View {
    @EnvironmentObject var session:SessionStore; @StateObject private var vm=TicketViewModel()
    var body:some View { ScrollView { VStack(alignment:.leading,spacing:16) {
        Text("Hola, \(session.user?.name ?? "Cliente")").font(.title2.bold())
        LazyVGrid(columns:[GridItem(.flexible()),GridItem(.flexible())]) {
            MetricCard(title:"Tickets",value:"\(vm.tickets.count)",icon:"ticket",color:.blue)
            MetricCard(title:"Alertas",value:"\(MockData.alerts.count)",icon:"bell.badge",color:.orange)
            MetricCard(title:"Servidores",value:"\(MockData.servers.count)",icon:"server.rack",color:.green)
            MetricCard(title:"Disponibilidad",value:"99.1%",icon:"chart.line.uptrend.xyaxis",color:.cyan)
        }
        Text("Alertas recientes").font(.headline)
        ForEach(MockData.alerts){a in VStack(alignment:.leading){Text(a.title).bold();Text(a.detail).font(.caption).foregroundStyle(.secondary)}.padding().frame(maxWidth:.infinity,alignment:.leading).background(.thinMaterial,in:RoundedRectangle(cornerRadius:12))}
    }.padding() }.navigationTitle("Dashboard").task{if let id=session.user?.id{await vm.load(userId:id)}} }
}
struct MetricCard:View { let title:String,value:String,icon:String,color:Color; var body:some View { VStack(alignment:.leading,spacing:8){Image(systemName:icon).foregroundStyle(color);Text(value).font(.title.bold());Text(title).foregroundStyle(.secondary)}.padding().frame(maxWidth:.infinity,alignment:.leading).background(color.opacity(0.12),in:RoundedRectangle(cornerRadius:14)) } }

struct MonitoringView:View { var body:some View { List(MockData.servers){s in HStack { Circle().fill(s.status=="En línea" ? .green:.orange).frame(width:12,height:12);VStack(alignment:.leading){Text(s.name).bold();Text("CPU \(s.cpu)% · Disponibilidad \(s.availability,specifier:"%.1f")%").font(.caption).foregroundStyle(.secondary)};Spacer();Text(s.status).font(.caption)} }.navigationTitle("Infraestructura") } }

struct AlertsView:View { var body:some View { List(MockData.alerts){a in Label { VStack(alignment:.leading){Text(a.title).bold();Text(a.detail).font(.caption)} } icon:{Image(systemName:a.level=="Crítica" ? "exclamationmark.triangle.fill":"checkmark.circle.fill").foregroundStyle(a.level=="Crítica" ? .red:.green)} }.navigationTitle("Alertas") } }

struct ProfileView:View { @EnvironmentObject var session:SessionStore; var body:some View { List { Section("Cuenta"){LabeledContent("Nombre",value:session.user?.name ?? "");LabeledContent("Correo",value:session.user?.email ?? "");LabeledContent("Empresa",value:session.user?.company ?? "")} Section{NavigationLink("Ver alertas"){AlertsView()};Button("Cerrar sesión",role:.destructive){session.signOut()}} }.navigationTitle("Perfil") } }
