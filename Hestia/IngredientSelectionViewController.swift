//
//  IngredientSelectionViewController.swift
//  Hestia
//
//  Created by Jonathan Long on 2/13/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

/*
- Here is the recipe creation flow
1. Name recipe, give a type/genre (Type: Thai, Indian, Asian, American, French, Salad, Soup Genre: Breakfast, Brunch, lunch, dinner 
2. Next (this ViewController) order ingredients that are common to the type/genre (similar to the Apple Music on boarding)
3. The user has some choices
	a. Select all the ingredients
	b. Tap a show more button
	c. Sort by types (Produce, baking items, spices, other things?)
	d. There is a custom/other option where you can type in some ingredient
4. Next VC lists all the ingredients with the first one select. On the right lists a bunch of different types of measurements (1 cup, 1 tbsp, 1sp, a handful, a pinch, __ ml, __ oz, etc)
*/

import UIKit

protocol BubbleViewDataSource {
	func numberOfBubbles(in bubbleView : BubbleView) -> Int
	func bubble(at indexPath: IndexPath) -> Bubble
}

protocol BubbleViewDelegate {
	func bubbleView(_ bubbleView: BubbleView, didSelectBubbleAt indexPath: IndexPath)
}

class Bubble : UIView {
	
}

class BubbleView : UIView {
	let containerView = UIView()
	let PI = CGFloat(M_PI)
	var delegate : BubbleViewDelegate?
	var dataSource : BubbleViewDataSource?
	var currentAreaConsumed : CGFloat = 0.0
	var totalArea : CGFloat {
		let radius = frame.width / 2
		return radius * radius * PI
	}
	var equalAreaValue : CGFloat {
		guard let theDataSource = dataSource else {fatalError("I need a datasource.")}
		let numberOfBubbles = theDataSource.numberOfBubbles(in: self)
		return totalArea/CGFloat(numberOfBubbles)
	}
	
	// Mark - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(containerView)
	}
	
	convenience init(dataSource : BubbleViewDataSource?, delegate : BubbleViewDelegate?) {
		self.init(frame: CGRect.zero)
		self.delegate = delegate
		self.dataSource = dataSource
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSubview(containerView)
	}
	
	// Mark: Helpers
	func areaForBubble(at index: IndexPath) -> CGFloat {
		let minVal = min(equalAreaValue/2, equalAreaValue - 7)
		let maxVal = (equalAreaValue + 7) - minVal
		return CGFloat(arc4random_uniform(UInt32(maxVal) + UInt32(minVal)))
	}
	
	// Mark: Layout
	override func layoutSubviews() {
		super.layoutSubviews()
		guard let theDataSource = dataSource else { return }
		let numberOfBubbles = theDataSource.numberOfBubbles(in: self)
		
		for i in stride(from: 0, to: numberOfBubbles, by: 1) {
			let nextBubble = theDataSource.bubble(at: IndexPath(row: i, section: 0))
			containerView.addSubview(nextBubble)
		}
	}
	
	
	func layoutConstraints(for bubble : Bubble, at indexPath : IndexPath) -> [NSLayoutConstraint] {
		var constraints : [NSLayoutConstraint] = []
		
		let radius = sqrt(areaForBubble(at: indexPath) / PI)
		constraints.append(NSLayoutConstraint(item: bubble, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: radius * 2))
		constraints.append(NSLayoutConstraint(item: bubble, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: radius * 2))
		
		//(x – h)2 + (y – k)2 = r2
		
		//What if we stored a bunch of blocks that represent each circle and can recall any point at anytime?
		var centerX = self.center.x
		var centerY = self.center.y
		if indexPath.row == 0 {
			constraints.append(NSLayoutConstraint(item: bubble, attribute: .centerX, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: centerX))
			constraints.append(NSLayoutConstraint(item: bubble, attribute: .centerY, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: centerY))
		}
		else {
//			centerX =
		}
		constraints.append(NSLayoutConstraint(item: bubble, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1, constant: 2))
		constraints.append(NSLayoutConstraint(item: bubble, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 2))
		
	}
	
}

class BubbleViewController : UIViewController {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
}

class IngredientSelectionViewController: UIViewController {
	
	class IngredientClusterView: UIView {
		
		let ingredients : [String]
		
		override init(frame : CGRect) {
			self.ingredients = []
			super.init(frame: frame)
			
		}
		
		required init?(coder aDecoder: NSCoder) {
			self.ingredients = []
			super.init(coder: aDecoder)
		}
		
		required init(ingredients : [String]) {
			self.ingredients = ingredients
			super.init(frame: CGRect.zero)
		}
		
		func addIngredientViews() {
			let leftAnchor = self.leftAnchor
			let rightAnchor = self.rightAnchor
			for ingredient in self.ingredients {
				let ingredientView = UIView()
				ingredientView.translatesAutoresizingMaskIntoConstraints = false
				self.addSubview(ingredientView)
				ingredientView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
				
				let ingredientLabel = UILabel()
				ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
				ingredientLabel.text = ingredient
				ingredientView.addSubview(ingredientLabel)
				ingredientLabel.leftAnchor.constraint(equalTo: ingredientView.leftAnchor).isActive = true
				ingredientLabel.rightAnchor.constraint(equalTo: ingredientView.rightAnchor).isActive = true
				ingredientLabel.topAnchor.constraint(equalTo: ingredientView.topAnchor).isActive = true
				ingredientLabel.bottomAnchor.constraint(equalTo: ingredientView.bottomAnchor).isActive = true
				
				
				
				
			}
		}
	}
	
	let ingredients = ["tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe"]
	
    override func viewDidLoad() {
		super.viewDidLoad()
//		var count = 0.0
		var angle = 0.0
		let spacing = 50.0
		let step = M_PI/16; //128 steps per full circle, so lines are short.
		var newX = 0.0
		var newY = 0.0
		for ingredient in ingredients {
			newY = sin(angle) * spacing// + angle ;
			newX = cos(angle) * spacing// + angle ;
			angle += step;
//			let newX = 10 * (exp(0.3*count) * cos(angle))
//			let newY = exp(0.3*count) * sin(angle)
			let button = UIButton(type: .roundedRect)
			button.setTitle(ingredient, for: .normal)
			button.translatesAutoresizingMaskIntoConstraints = false
			self.view.addSubview(button)
			button.widthAnchor.constraint(equalToConstant: 100).isActive = true
			button.heightAnchor.constraint(equalToConstant: 100).isActive = true
			//			button.centerXAnchor.constraint
			button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: CGFloat(newX)).isActive = true
			button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: CGFloat(newY)).isActive = true
			button.center = CGPoint(x: self.view.center.x + CGFloat(newX), y: self.view.center.y + CGFloat(newY))
//			print("View(\(self.view.center.x), \(self.view.center.y)");
//			print("button(\(self.view.center.x + CGFloat(newX)), \(self.view.center.y + CGFloat(newY))");
			print("new(\(newX), \(newY)) step: \(angle)")
//			print("input(count: \(count), angle: \(angle))")
//			count += 1.0
//			angle += 45.0
		}

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
