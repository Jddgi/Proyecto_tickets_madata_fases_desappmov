import Foundation

@MainActor final class TicketViewModel: ObservableObject {
    @Published var tickets:[Ticket]=[]; @Published var errorMessage=""; @Published var isLoading=false
    func load(userId:Int) async { isLoading=true; defer{isLoading=false}; do { let r:ListResponse<Ticket>=try await APIClient.shared.send("tickets/list.php?user_id=\(userId)"); tickets=r.data } catch { errorMessage=error.localizedDescription } }
    func create(userId:Int,title:String,details:String,priority:TicketPriority) async throws {
        struct Created:Decodable{let success:Bool;let message:String;let id:Int?}
        let _:Created=try await APIClient.shared.send("tickets/create.php",method:"POST",body:["user_id":userId,"title":title,"details":details,"priority":priority.rawValue])
        await load(userId:userId)
    }
}
@MainActor final class ServiceViewModel:ObservableObject {
    @Published var services:[ServiceItem]=[]; @Published var errorMessage=""
    func load(userId:Int) async { do { let r:ListResponse<ServiceItem>=try await APIClient.shared.send("services/list.php?user_id=\(userId)"); services=r.data } catch { errorMessage=error.localizedDescription } }
}

enum MockData {
    static let servers=[ServerItem(name:"Servidor ERP",status:"En línea",cpu:42,availability:99.9),ServerItem(name:"Servidor SQL",status:"Advertencia",cpu:91,availability:97.8),ServerItem(name:"Gateway NOC",status:"En línea",cpu:35,availability:99.7)]
    static let alerts=[AlertItem(title:"Uso elevado de CPU",detail:"Servidor SQL supera 90%",level:"Crítica",date:.now),AlertItem(title:"Respaldo completado",detail:"Copia nocturna finalizada",level:"Informativa",date:.now.addingTimeInterval(-3600))]
}
