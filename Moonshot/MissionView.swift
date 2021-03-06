//
//  MissionView.swift
//  Moonshot
//
//  Created by Juliette Rapala on 10/30/20.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    let allMissions: [Mission]
    let allAstronauts: [Astronaut]
    
    // Find information about astronauts in crew
    init(mission: Mission, astronauts: [Astronaut], allMissions: [Mission]) {
        self.mission = mission
        self.allMissions = allMissions
        self.allAstronauts = astronauts
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                        .accessibility(label: Text("\(mission.displayName) badge"))
                
                    HStack() {
                        Text("Launch Date:")
                            .font(.headline)
                        Text(self.mission.formattedLaunchDate)
                    }
                    .padding(.top)
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("Launch Date: \(mission.formattedLaunchDate)"))
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id:\.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, allMissions: allMissions, allAstronauts: allAstronauts)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    HStack {
                                        if (crewMember.role == "Commander") {
                                            Image(systemName: "star.circle.fill")
                                                .foregroundColor(.yellow)
                                        }
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts, allMissions: missions)
    }
}
