//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Zanette Ciriaco on 08/12/21.
//

import UIKit
import CoreData

class NewNoteViewController: UIViewController {
    
    private var saveNoteButton: UIButton!
    private var noteText: UITextView!
    private var noteTitle: UITextField!
    private var stack: UIStackView!
    private var note: NSManagedObject?
    
    private var noteManage: NotesManage!
    
    init(note: NSManagedObject?){
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Adicionar"
        navigationItem.backButtonTitle = "Voltar"
        
        noteManage = NotesManage()
        setupStack()
    }
    
    
    private func setupStack(){
        stack = UIStackView()
        view.addSubview(stack)
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        
        // titulo
        
        noteTitle = UITextField()
        stack.addArrangedSubview(noteTitle)
        
        noteTitle.placeholder = "Titulo"
        noteTitle.font = .boldSystemFont(ofSize: 20)
        noteTitle.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        noteTitle.layer.borderWidth = 1.0
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.clipsToBounds = true
        noteTitle.borderStyle = .roundedRect
        
        noteTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if let title = note?.value(forKey: "title") as? String {
            noteTitle.text = title
        }
        
       
        //nota
        
        noteText = UITextView()
        stack.addArrangedSubview(noteText)

        noteText.textAlignment = NSTextAlignment.left
        noteText.backgroundColor = UIColor.white
        noteText.textContainer.lineBreakMode = .byWordWrapping
        noteText.font = UIFont.systemFont(ofSize: 18)
        noteText.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        noteText.layer.borderWidth = 1.0;
        noteText.layer.cornerRadius = 10
        noteText.isEditable = true
        noteText.isScrollEnabled = true
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.clipsToBounds = true
        noteText.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        if let noteText = note?.value(forKey: "noteText") as? String {
            self.noteText.text = noteText
        }
        
        
        //botao para salvar
        
        saveNoteButton = UIButton()
        saveNoteButton.backgroundColor = .black
        saveNoteButton.setTitle("Salvar", for: .normal)
        saveNoteButton.layer.cornerRadius = 20
        saveNoteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        saveNoteButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        stack.addArrangedSubview(saveNoteButton)
        
        saveNoteButton.translatesAutoresizingMaskIntoConstraints = false
        saveNoteButton.clipsToBounds = true
        saveNoteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func handleSaveButton (){
        
        if noteText.text.isEmpty == false{
            if note != nil {
                self.noteManage.updateNote(note: note!, title: noteTitle.text!, text: noteText.text!)
                
            } else {
                let note = NoteModel(title: noteTitle.text!, noteText: noteText.text!)
                self.noteManage.saveNote(note: note)
            }
            
        }
        
        
        navigationController?.popViewController(animated: true)
    }

    

   

}
