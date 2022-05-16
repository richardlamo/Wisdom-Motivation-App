//
//  Wisdom_Motivation_AppApp.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 11/5/2022.
//

import SwiftUI
import CoreData

@main
struct Wisdom_Motivation_AppApp: App {
    
    let persistenceController = PersistenceController.shared

    @State private var  motivationItems:[Motivation] = []
    
    private var imageItems:[Int] = []

    init() {
        imageItems = stride(from: 1, through: 22, by: 1).shuffled()
        print("\(imageItems)")
    }
    
    var body: some Scene {
        

        WindowGroup {
            WisdomMotivationView(allItems: $motivationItems, allImages: imageItems)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear() {
                    fetchRecords()
                    if (motivationItems.isEmpty) {
                        print("Loading motivations for the first time!")
                        loadMotivations()
                        fetchRecords()
                        
                    } else {
                        print("Motivations already loaded")
                    }
                    motivationItems.shuffle()
                }
        }
    }
    

    
    func fetchRecords()  {
        let fetchRequest =
            NSFetchRequest<Motivation>(entityName: "Motivation")
        
        let sectionSortDescriptor = NSSortDescriptor(keyPath: \Motivation.id, ascending: true)

        let sortDescriptors = [sectionSortDescriptor] //, secondSortDescriptor]

        fetchRequest.sortDescriptors = sortDescriptors
        
        // Get a reference to a NSManagedObjectContext
        let context = persistenceController.container.viewContext

        // Fetch a single object. If the object does not exist,
        // nil is returned
        do {
            let objects = try context.fetch(fetchRequest)
            if objects.count > 0 {
                motivationItems = objects.suffix(objects.count)
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func loadMotivations() {
        
        let viewContext = persistenceController.container.viewContext
        
        print("Load Data")
        guard let filePath = Bundle.main.path(forResource: "Motivation", ofType: "csv") else {
            print("file not found")
            return
        }

        do {
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            let lines: [String] = contents.components(separatedBy: "\n") as [String]
            for line in lines {
                let fields: [String] = separateFields(line: line)
                if fields.count >= 2 {
                    let newItem = Motivation(context: viewContext)
                    newItem.content = fields[1]
                    newItem.author = fields[2]
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
        } catch {
                print("File Read Error for file \(filePath)")
        }
    }
    

}
