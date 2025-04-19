//
//  ContentView.swift
//  SwiftyGA_Demo
//
//  Created by Ivan Lo on 19/4/2025.
//

import SwiftUI

struct ContentView: View, SwiftyGA_GAComputationDelegate {
    
    //SwiftyGA delegates callbacks
    func GAComputationInitCall(initPopulation: SwiftyGA_Population) {
        print("*** Init ***")
        curStatus = "Init"
    }
    
    func GAComputationFinishedCall(finalPopulation: SwiftyGA_Population) {
        print("*** Finished ***")
        curStatus = "Finished"
    }
    
    func GAComputationGenerationCall(currentPopulation: SwiftyGA_Population, allOffsprings: [SwiftyGA_Chromosome], atGeneration: Int) {
        print("*** Running Generation: \(atGeneration) ***")
        print("\nBest fitness = \(currentPopulation.bestChromosome.fitness)")
        print("\nBest chromosome = \(currentPopulation.bestChromosome.genes)\n")
        curStatus = "Gen: \(atGeneration), best fit: \(currentPopulation.bestChromosome.fitness)"
    }
    //
    
    // Swifty GA Demo content
    // *** Detail of each generations is saved in GALog.plist file, the saved path is printed in the debug console.
    
    func maxProblemPressed() {
        //Parameters
        SwiftyGA_Parameters.singleton.geneType = .IntGene
        SwiftyGA_Parameters.singleton.crossoverMethod = .OnePointCrossoverMethod
        SwiftyGA_Parameters.singleton.crossoverRate = 0.9
        SwiftyGA_Parameters.singleton.mutationMethod = .SwapMutationMethod
        SwiftyGA_Parameters.singleton.mutationMethod_subsetLength = 1
        SwiftyGA_Parameters.singleton.mutationRate = 0.05
    
        //Fitness
        SwiftyGA_Parameters.singleton.fitnessGoal = .Maximising
        //Max log chromosome
        SwiftyGA_Parameters.singleton.maxLogChromosomeTotalGenerations = 50000
        
        //Chromosome Allele Set
        SwiftyGA_Parameters.singleton.chromosomeLength = 20
        SwiftyGA_Parameters.singleton.alleleSet = Array(0...10) //number 0 - 10
        
        SwiftyGA_Parameters.singleton.populationSize = 500
        SwiftyGA_Parameters.singleton.noOfSelectedParents = 200 //must be Even number
        SwiftyGA_Parameters.singleton.terminateGeneration = 100
        
        //Create GA Computation and Run
        let gaComputation = SwiftyGA_GAComputation()
        gaComputation.delegate = self
        let defaultFitFunc = SwiftyGA_FitnessFunction()
        gaComputation.fitnessFunction = defaultFitFunc
        gaComputation.run()
    }
    
    
    func toyTSPPressed(){
        //General parameter
        SwiftyGA_Parameters.singleton.geneType = .IntGeneTSPRoundTrip
        SwiftyGA_Parameters.singleton.crossoverMethod = .PMXCrossoverTSPRoundTrip
        SwiftyGA_Parameters.singleton.crossoverRate = 0.9
        SwiftyGA_Parameters.singleton.mutationMethod = .SwapMutationTSPRoundTripMethod
        SwiftyGA_Parameters.singleton.mutationMethod_subsetLength = 1
        SwiftyGA_Parameters.singleton.mutationRate = 0.05
        
        //Fitness
        SwiftyGA_Parameters.singleton.fitnessGoal = .Minimising
        
        //Max log chromosome
        SwiftyGA_Parameters.singleton.maxLogChromosomeTotalGenerations = 5000
        
        SwiftyGA_Parameters.singleton.populationSize = 60
        SwiftyGA_Parameters.singleton.noOfSelectedParents = 30 //must be Even number
        SwiftyGA_Parameters.singleton.terminateGeneration = 100
        
        
        //Test data
        var cities:[LocationCity] = [LocationCity]()
        cities.append(LocationCity(centerPoint: CGPoint(x: 0, y: 0), cityIndex: 0))
        cities.append(LocationCity(centerPoint: CGPoint(x: 100, y: 0), cityIndex: 1))
        cities.append(LocationCity(centerPoint: CGPoint(x: 0, y: 50), cityIndex: 2))
        cities.append(LocationCity(centerPoint: CGPoint(x: 100, y: 50), cityIndex: 3))
        cities.append(LocationCity(centerPoint: CGPoint(x: 0, y: 100), cityIndex: 4))
        cities.append(LocationCity(centerPoint: CGPoint(x: 100, y: 100), cityIndex: 5))
        cities.append(LocationCity(centerPoint: CGPoint(x: 0, y: 150), cityIndex: 6))
        cities.append(LocationCity(centerPoint: CGPoint(x: 100, y: 150), cityIndex: 7))
        cities.append(LocationCity(centerPoint: CGPoint(x: 0, y: 200), cityIndex: 8))
        cities.append(LocationCity(centerPoint: CGPoint(x: 100, y: 200), cityIndex: 9))
        
        SwiftyGA_Parameters.singleton.chromosomeLength = cities.count + 1 // becasue round trip
        SwiftyGA_Parameters.singleton.alleleSet = Array(0...cities.count-1)
        
        //Fitness function
        let myCustomFitnessFunction = MyCustomFitnessFunction()
        myCustomFitnessFunction.allCities = cities
        
        //Create GA Computation and Run
        let gaComputation = SwiftyGA_GAComputation()
        gaComputation.delegate = self
        gaComputation.fitnessFunction = myCustomFitnessFunction
        gaComputation.run()
    }
    //
    
    
    @State var curStatus: String = "Idle"
    let gaLogPlistToShare = SwiftyGA_GAComputation().gaLog.logFileUrl.standardizedFileURL
    
    var body: some View {
        VStack {
            Text("SwiftyGA Demo")
            Button("MaxProblem") {
                maxProblemPressed()
            }.padding(10)
            
            Button("Toy Travel Salesman") {
                toyTSPPressed()
            }.padding(10)
            
            Text("Status: \(curStatus)").padding(10)
            
            ShareLink(item: gaLogPlistToShare) {
                Text("Open GALog.plist")
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
