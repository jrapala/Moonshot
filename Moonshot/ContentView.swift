//
//  ContentView.swift
//  Moonshot
//
//  Created by Juliette Rapala on 10/28/20.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showCrewNames = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts, allMissions: missions)) {
                    MissionItem(mission: mission, showCrewNames: showCrewNames)
                
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showCrewNames.toggle()
                }, label: {
                    Text(self.showCrewNames ? "Show Launch Dates" : "Show Crew Names")
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
