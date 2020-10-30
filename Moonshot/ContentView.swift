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
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
