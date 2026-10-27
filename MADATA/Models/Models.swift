import Foundation

enum TicketPriority: String, Codable, CaseIterable, Identifiable { case baja, media, alta, critica; var id:String{rawValue} }
enum TicketStatus: String, Codable { case abierto, en_proceso, resuelto, cerrado }

struct User: Codable, Identifiable {
    let id: Int; let name: String; let email: String; let company: String
}
struct AuthResponse: Codable { let success: Bool; let message: String; let token: String?; let user: User? }
struct Ticket: Codable, Identifiable {
    let id: Int; let title: String; let details: String; let priority: TicketPriority; let status: TicketStatus; let createdAt: String
    enum CodingKeys:String,CodingKey { case id,title,details,priority,status; case createdAt="created_at" }
}
struct ServiceItem: Codable, Identifiable {
    let id:Int; let name:String; let details:String; let status:String; let validUntil:String?
    enum CodingKeys:String,CodingKey { case id,name,details,status; case validUntil="valid_until" }
}
struct ServerItem: Identifiable { let id=UUID(); let name:String; let status:String; let cpu:Int; let availability:Double }
struct AlertItem: Identifiable { let id=UUID(); let title:String; let detail:String; let level:String; let date:Date }
struct ListResponse<T:Codable>: Codable { let success:Bool; let data:[T]; let message:String? }
