//
//  AstronautView.swift
//  Moonshot
//
//  Created by Juliette Rapala on 10/30/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let allMissions: [Mission]
    let missions: [Mission]

    // Find information about astronaut's missions
    init(astronaut: Astronaut, allMissions: [Mission]) {
        self.allMissions = allMissions
        self.astronaut = astronaut
        
        var matches = [Mission]()

        for mission in allMissions {
            innerLoop: for _ in mission.crew {
                if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                    matches.append(mission)
                    break innerLoop
                }
            }
        }

        self.missions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    Text("Missions:")
                        .padding(.leading)
                        .font(.headline)
                 
                    ForEach(self.missions) { mission in
                        MissionItem(mission: mission)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], allMissions: missions)
    }
}
