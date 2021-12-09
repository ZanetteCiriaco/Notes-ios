//
//  ViewController.swift
//  Notes
//
//  Created by Zanette Ciriaco on 07/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    private var addNoteButton: UIButton!
    private var notesManage = NotesManage()
    private var notesArray = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesArray = notesManage.getNotes()
        tableView.reloadData()
    }
    
    
    private func setupNavigation(){
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationItem.title = "Notas"
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNoteButton))
    }
    
    
    private func setupTableView(){
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseId)
        
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    @objc func handleAddNoteButton(){
        
        let newNoteView = NewNoteViewController(note: nil)
        navigationController?.pushViewController(newNoteView, animated: true)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseId, for: indexPath) as! NoteTableViewCell
        let note = notesArray[indexPath.row]
       
        cell.noteTitle.text = note.value(forKey: "title") as? String
        cell.noteText.text = note.value(forKey: "noteText") as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        func deleteLine() {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                let noteToDelete = self.notesArray[indexPath.row]
                self.notesArray.remove(at: indexPath.row)
                self.notesManage.delete(note: noteToDelete)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
        
        let alert = UIAlertController(title: "Tem certeza que deseja excluir essa nota?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let action2 = UIAlertAction(title: "Excluir", style: .destructive, handler: {_ in deleteLine()})
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.notesArray[indexPath.row]
        let newNoteView = NewNoteViewController(note: note)
        navigationController?.pushViewController(newNoteView, animated: true)
    }
    
    
}


