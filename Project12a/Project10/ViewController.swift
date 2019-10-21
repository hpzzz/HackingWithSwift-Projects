//
//  ViewController.swift
//  Project10
//
//  Created by Karol Harasim on 02/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue Person Cell")
        }
        let person = people[indexPath.item]
        cell.name.text = person.name
        let path = getDocumentDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Do you want to rename or delete the picture?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) {
            [weak self] _ in
            self?.deleteCell(at: indexPath)
            collectionView.reloadData()
            })
        ac.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self] _ in
                    let renameAC = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            renameAC.addTextField()
            renameAC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            renameAC.addAction(UIAlertAction(title: "OK", style: .default) {
                [weak self, weak renameAC] _ in
                            guard let newName = renameAC?.textFields?[0].text else { return }
                            person.name = newName
                            self?.save()
                            self?.collectionView.reloadData()
                })
            self?.present(renameAC, animated: true)
        })
        present(ac, animated: true)
        
//        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
//        ac.addTextField()
//        ac.addAction(UIAlertAction(title: "OK", style: .default) {
//            [weak self, weak ac] _ in
//            guard let newName = ac?.textFields?[0].text else { return }
//            person.name = newName
//            self?.collectionView.reloadData()
//        })
//
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        present(ac, animated: true)
    }
    
    func deleteCell(at indexPath: IndexPath) {
        people.remove(at: indexPath.row)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func deleteTapped() {
        print("LOL")
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        present(picker, animated: true)
        
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
    
    
}

