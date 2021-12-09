//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Zanette Ciriaco on 07/12/21.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    var noteTitle: UILabel!
    var noteText: UILabel!
    static let reuseId = "NoteTableViewCell"


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitle()
        setupNoteText()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupTitle(){
        noteTitle = UILabel()
        contentView.addSubview(noteTitle)
        
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.font = .boldSystemFont(ofSize: 20)
        noteTitle.numberOfLines = 0
        
        noteTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        noteTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    private func setupNoteText(){
        noteText = UILabel()
        contentView.addSubview(noteText)
        
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.font = .systemFont(ofSize: 16)
        noteText.numberOfLines = 0
        
        noteText.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 10).isActive = true
        noteText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        noteText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        noteText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

}
