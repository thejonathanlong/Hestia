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

class IngredientSelectionViewController: UIViewController {
	
	let ingredients = ["tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe"]
	
    override func viewDidLoad() {
		super.viewDidLoad()
		var count = 0.0
		var angle = 0.0
		for ingredient in ingredients {
			let newX = exp(0.03*count) * cos(angle)
			let newY = exp(0.03*count) * sin(angle)
			let button = UIButton(type: .roundedRect)
			button.setTitle(ingredient, for: .normal)
			button.translatesAutoresizingMaskIntoConstraints = false
			self.view.addSubview(button)
			button.widthAnchor.constraint(equalToConstant: 100).isActive = true
			button.heightAnchor.constraint(equalToConstant: 100).isActive = true
			//			button.centerXAnchor.constraint
			button.center = CGPoint(x: self.view.center.x + CGFloat(newX), y: self.view.center.y + CGFloat(newY))
			print("View(%f, %f)", self.view.center.x, self.view.center.y);
			print("button(%f, %f)", self.view.center.x + CGFloat(newX), self.view.center.y + CGFloat(newY));
			
			count += 1
			angle += 20.0
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
