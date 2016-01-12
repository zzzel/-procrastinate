//
//  CloudKitHandler.swift
//  !procrastinate
//
//  Created by Zel Marko on 1/12/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import CloudKit

class CloudHandler {
	let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
	
	func addTask(task: Task, completion: String -> ()) {
		let newTask = CKRecord(recordType: "Task")
		newTask.setValue(task.title, forKey: "Title")
		newTask.setValue(task.completed, forKey: "Completed")
		privateDatabase.saveRecord(newTask, completionHandler: { record, error in
			if let error = error {
				print(error.localizedDescription)
			} else {
				completion(record!.recordID.recordName)
				print("Saved \(record!.recordID.recordName)")
			}
		})
	}
	
	func getTasks(completion: [Task] -> ()) {
		let query = CKQuery(recordType: "Task", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
		privateDatabase.performQuery(query, inZoneWithID: nil) { records, error in
			if let error = error {
				print(error.localizedDescription)
			} else {
				if let records = records {
					var tasks = [Task]()
					for record in records {
						let task = Task(ID: record.recordID.recordName, title: record["Title"] as! String, completed: record["Completed"] as! Bool)
						tasks.append(task)
					}
					completion(tasks)
				}
			}
		}
	}
}
