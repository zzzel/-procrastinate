//
//  ViewController.swift
//  !procrastinate
//
//  Created by Zel Marko on 1/9/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var tasks: [Task] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tasks = [
			Task(title: "Figure out how to add items"),
			Task(title: "What to use for Backend?!")
		]
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell
		
		cell.delegate = self
		cell.task = tasks[indexPath.row]
		
		return cell
	}
}

extension ViewController: UITextViewDelegate {

	func textViewDidChange(textView: UITextView) {
		
		print(textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.max)))
//		let fixedWidth = textView.frame.size.width
//		textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//		let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//		
//		if newSize.height != descriptionTextViewConstraint.constant && newSize.height < 100 {
//			descriptionTextViewConstraint.constant = newSize.height
//			addFieldHeightConstraint.constant = newSize.height + 150
//			view.layoutIfNeeded()
//		}
	}
}

extension ViewController: TaskCellDelegate {
	
	func completeTask(task: Task) {
		print("Complete \(task.title)")
	}
	func deleteTask(task: Task) {
		print("Delete \(task.title)")
		let index = tasks.indexOf { $0.title == task.title }
		tasks.removeAtIndex(index!)
		tableView.beginUpdates()
		tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)], withRowAnimation: .Right)
		tableView.endUpdates()
	}
}

