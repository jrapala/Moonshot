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
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts, allMissions: missions)) {
                    MissionItem(mission: mission)
                
                }
            }
            .navigationTitle("Moonshot")
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
                Text(mission.formattedLaunchDate)
            }
        }
    }
}
