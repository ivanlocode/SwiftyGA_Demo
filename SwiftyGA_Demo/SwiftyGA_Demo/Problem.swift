//
//  Problem.swift
//  SwiftyGA_Demo
//
//  Created by Ivan Lo on 19/4/2025.
//

class Problem:SwiftyGA_GAComputationDelegate{
    func GAComputationInitCall(initPopulation: SwiftyGA_Population) {
        print("*** Init ***")
    }
    
    func GAComputationFinishedCall(finalPopulation: SwiftyGA_Population) {
        print("*** Finished ***")
    }
    
    func GAComputationGenerationCall(currentPopulation: SwiftyGA_Population, allOffsprings: [SwiftyGA_Chromosome], atGeneration: Int) {
        print("*** Running Generation: \(atGeneration) ***")
    }
    
    
}
