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

struct MissionItem: View {
    let mission: Mission
    let showCrewNames: Bool
    
    init(mission: Mission, showCrewNames: Bool = false) {
        self.mission = mission
        self.showCrewNames = showCrewNames
    }
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                // If we provide a frame, just use .scaledToFit() shortcut
                // .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(showCrewNames ? getCrewNames() : mission.formattedLaunchDate)
            }
        }
    }
    
    func getCrewNames() -> String {
        var names = [String]()
        for member in mission.crew {
            names.append(member.name.capitalizingFirstLetter())
        }
        return names.joined(separator: ", ")
    }

}
