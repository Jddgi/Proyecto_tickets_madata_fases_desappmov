//
//  ServicesView.swift
//  Madata_tickets_proyecto
//
//  Created by Juandd200511@gmail.com on 29/09/26.
//

import SwiftUI

struct ServicesView: View {

    let services = [
        "Monitoreo NOC",
        "Cloud Hosting",
        "Soporte Técnico",
        "VPN Empresarial"
    ]

    var body: some View {

        List {

            ForEach(services, id: \.self) { service in

                Label(
                    service,
                    systemImage: "checkmark.circle.fill"
                )
            }
        }
        .navigationTitle("Servicios")
    }
}
