//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Gor on 5/14/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var notes: [Note] = [] {
        didSet {
            notesTable.reloadData()
        }
    }
    @IBOutlet weak var notesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        notes = CoreDataManager.shared.getNotes()
    }
    
    @IBAction private func addNote() {
        func addNote(_ title: String) {
            guard !title.isEmpty else { return }
            let note = CoreDataManager.shared.saveNote(title: title)
            notes.append(note)
        }
        
        let alert = UIAlertController(title: "New Note", message: "Add a new note", preferredStyle: .alert)
     
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let textField = alert.textFields?.first, let noteToSave = textField.text else { return }
            addNote(noteToSave)
        }
 
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title ?? "No title"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
