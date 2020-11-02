//
//  MissionItem.swift
//  Moonshot
//
//  Created by Juliette Rapala on 11/2/20.
//

import SwiftUI

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

struct MissionItem_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionItem(mission: missions[1])
    }
}
