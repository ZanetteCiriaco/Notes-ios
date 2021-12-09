//
//  NotesManage.swift
//  Notes
//
//  Created by Zanette Ciriaco on 08/12/21.
//

import Foundation
import UIKit
import CoreData


struct NotesManage {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func saveNote(note: NoteModel) {
        
        let noteManage = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
        
        noteManage.setValue(note.title, forKey: "title")
        noteManage.setValue(note.noteText, forKey: "noteText")

        do {
            try context.save()
            print("sucesso")

        } catch {
            print("erro ao salvar")
        }
    }
    
    func updateNote(note: NSManagedObject, title: String, text: String){
        note.setValue(title, forKey: "title")
        note.setValue(text, forKey: "noteText")
        
        do {
            try context.save()
            print("sucesso")

        } catch {
            print("erro ao salvar")
        }
    }
    
    
    func getNotes() -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        var notesArray:[NSManagedObject] = []
        
        do {
            let notes = try context.fetch(request)
            notesArray = notes as! [NSManagedObject]
        
        } catch {
            print("nao deu certo")
        }
        
        return notesArray
    }
    
    
    func delete(note: NSManagedObject) {
        
        context.delete(note)
        
        do {
            try context.save()
            
        } catch {
            print("falha ao apagar")
        }
    }
}





