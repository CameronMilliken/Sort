//
//  GroupController.swift
//  Sort
//
//  Created by Cameron Milliken on 3/8/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation
class GroupController {
    
    static let shared = GroupController()
    
    var personList : [String] = []
    var groups : [Group] = []
    init() {
        self.personList = loadFromPersistentStorage()
    }
    
    // CRUD Functions
    
    //Create
    func createPerson(person: String) {
        self.personList.append(person)
        saveToPersistence()
       
    }
        
        
        
    func deletePerson(person: String) {
        guard let index = personList.index(of: person) else { return }
        personList.remove(at: index)
        saveToPersistence()
        
        }
        

        
        func fileURL() -> URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            let fileName = "personList.json"
            let fullURL = documentsDirectory.appendingPathComponent(fileName)
            print(fullURL)
            return fullURL
            
        }
        
        func saveToPersistence(){
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(self.personList)
                try data.write(to: fileURL())
            } catch{
                print("🤬 There was an error saving!🤬 \(error.localizedDescription)")
            }
        }
        
        func loadFromPersistentStorage() -> [String] {
            let decoder = JSONDecoder()
            do{
                let data = try Data(contentsOf: fileURL())
                let personList = try decoder.decode([String].self, from: data)
                return personList
            }catch{
                print("🐸🔫 There was an error decoding the JSON! \(error.localizedDescription)")
            }
            return []
        }
    func createGroup() {
            groups = []
        
    }
    
    
    
    
    
    
} // End of class
