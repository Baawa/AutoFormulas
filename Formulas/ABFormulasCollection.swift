//
//  ABFormulasCollection.swift
//  Formulas
//
//  Created by Albin Bååw on 2017-04-24.
//  Copyright © 2017 Albin Bååw. All rights reserved.
//

import UIKit

class ABFormulasCollection: NSObject {
    
    class func search(_ name:String) -> [ABFormula]{
		return sorted().filter { (formula) -> Bool in
			return formula.name.lowercased().contains(name.lowercased())
		}
    }
    
    class func get(_ name:String) -> ABFormula?{
		return collection.first(where: { (formula) -> Bool in
			return formula.name.lowercased() == name.lowercased()
		})
    }
	
	class func sorted() -> [ABFormula]{
		return collection.sorted(by: { (a, b) -> Bool in
			return a.name < b.name
		})
	}
    
	static let collection:[ABFormula] = [
		ABFormula(name: "Pythagora's Formula", desc: "Pythagora's Formula is used to find the length of the different sides in a triangle with an angle of 90 degrees.", type: .math, expression: "\u{221A}(@^2 + @^2) = @", formula: { (values) in
			var sum:Double = 0
			if values[0] == nil {
				if values[1] != nil && values[2] != nil {
					sum = sqrt(pow(values[2]!, 2) - pow(values[1]!, 2))
				}
			} else if values[1] == nil {
				if values[0] != nil && values[2] != nil {
					sum = sqrt(pow(values[2]!, 2) - pow(values[0]!, 2))
				}
			} else if values[2] == nil {
				if values[0] != nil && values[1] != nil {
					sum = sqrt(pow(values[1]!, 2) + pow(values[0]!, 2))
				}
			}
			
			return sum
		}),
		ABFormula(name: "Area - Square", desc: "In geometry a square is a regular quadrilateral, which means that is has four equal sides and four equal angles. The area (y) of a square is the side (x) squared. ", type: .math, expression: "@^2 = @", formula: { (values) -> Double in
			if values[0] != nil{
				return pow(values[0]!, 2)
			} else if values[1] != nil{
				return sqrt(values[1]!)
			}
			return 0
		}),
		ABFormula(name: "Area - Rectangle", desc: "In geometry a rectangle is any quadriteral with four right angles. The area (z) of a rectangle is equal to the base (x) multiplied by the height (y).", type: .math, expression: "@ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[2]! / values[1]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Area - Triangle", desc: "A triangle is a polygon with three edges and three vertices. A triangle with vertices A, B, and C is denoted \u{25B3}ABC. The area (z) of a triangle is equal to the base (x) multiplied by the height (y) divided by 2.", type: .math, expression: "(@ * @)/2 = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return 2*values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return 2*values[2]! / values[1]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return (values[0]! * values[1]!) / 2
				}
			}
			return 0
		}),
		ABFormula(name: "Area - Circle", desc: "A circle is a simple shape in geometry. It is the set of all points in a plane that are at a given distance from a given point, the centre. The area (y) of a circle is equal to the radius (x) squared multiplied by \u{03C0} (~3.14).", type: .math, expression: "\u{03C0} * @^2 = @", formula: { (values) -> Double in
			if values[0] != nil{
				return pow(values[0]!, 2) * 3.14
			} else if values[1] != nil{
				return sqrt(values[1]!/3.14)
			}
			return 0
		}),
		ABFormula(name: "Volume - Prism", desc: "In geometry, a prism is a polyhedron with an n-sided polygonal base, another congruent parallel base and n other faces joining corresponding sides of the two bases. The volume (u) of a prism is equal to the base (x) multiplied by the height (y) and the length (z) of the prism.", type: .math, expression: "@ * @ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! / (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! * values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Volume - Pyramid", desc: "In geometry a pyramid is a polyhedron formed by connecting a polygonal base and a point, called the apex. The volume (u) of a pyramid is equal to the base (x) multiplied by the height (y) and the length (z) of the prism divided by 3.", type: .math, expression: "(@ * @ * @)/3 = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return 3*values[3]! / (values[2]! * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return 3*values[3]! / (values[2]! * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return 3*values[3]! / (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return (values[2]! * values[0]! * values[1]!) / 3
				}
			}
			return 0
		}),
		ABFormula(name: "Volume - Sphere", desc: "A sphere is a perfectly round geometrical object in a three-dimensional space that forms the surface of a completely round ball. The volume (y) of a sphere is equal to (4/3)\u{03C0} (~3.14) multiplied by the radius(x) cubed.", type: .math, expression: "(4\u{03C0} * @^3)/3 = @", formula: { (values) -> Double in
			if values[0] != nil{
				return pow(values[0]!, 3) * 3.14 * 4 / 3
			} else if values[1] != nil{
				return cbrt(values[1]! * 3 / (3.14 * 4))
			}
			return 0
		}),
		ABFormula(name: "Volume - Cylinder", desc: "A cylinder is one of the most basic curvilinear geometric shapes, the surface formed by the points at a fixed distance from a given line segment, the axis of the cylinder. The volume (z) of a cylinder is equal to \u{03C0} multiplied by the radius (x) squared and the height (y) of the cylinder.", type: .math, expression: "\u{03C0} * @^2 * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return sqrt(values[2]! / (3.14 * values[1]!))
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[2]! / (3.14 * pow(values[0]!, 2))
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return 3.14 * pow(values[0]!, 2) * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Circumference - Rectangle", desc: "In geometry a rectangle is any quadriteral with four right angles. The circumference (z) of a rectangle is equal to the base (x) added to the height (y) multiplied by 2.", type: .math, expression: "(@ + @) * 2 = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return (values[2]! / 2) - values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return (values[2]! / 2) - values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return 2 * (values[0]! + values[1]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Circumference - Triangle", desc: "A triangle is a polygon with three edges and three vertices. A triangle with vertices A, B, and C is denoted \u{25B3}ABC. The circumference (u) of a triangle is equal to the sum of all sides (x, y, z).", type: .math, expression: "@ + @ + @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! - (values[2]! + values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! - (values[2]! + values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! - (values[0]! + values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! + values[0]! + values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Circumference - Circle", desc: "A circle is a simple shape in geometry. It is the set of all points in a plane that are at a given distance from a given point, the centre. The circumference (y) of a circle is equal to the radius (x) multiplied by 2\u{03C0} (~3.14).", type: .math, expression: "2\u{03C0} * @ = @", formula: { (values) -> Double in
			if values[0] != nil{
				return values[0]! * 3.14 * 2
			} else if values[1] != nil{
				return values[1]! / (3.14 * 2)
			}
			return 0
		}),
		ABFormula(name: "Linear equation", desc: "A linear equation is an algebraic equation in which each term is either a constant or the product of a constant and a single variable. The formula can by u = x * y + z", type: .math, expression: "@ * @ + @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return (values[3]! - values[2]!) / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return (values[3]! - values[2]!) / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! - (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! + (values[0]! * values[1]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Acceleration", desc: "In physics acceleration is the rate of change of velocity of an object. The acceleration (z) is equal to the velocity (x) divided by the time (y).", type: .physics, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Velocity", desc: "Velocity is the rate of change of the displacement, the difference between the final and the initial position of an object. The velocity (z) is equal to the distance (x) divided by the time (y).", type: .physics, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Force", desc: "In physics, a force is any interaction which tends to change the motion of an object. The force (z) of an object is equal to the object's mass (x) multiplied by its acceleration (y).", type: .physics, expression: "@ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[2]! / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Friction", desc: "Friction is a surface force that opposes relative motion. The friction (z) is equal to the product of the normal force (x) and the friction coefficient (y).", type: .physics, expression: "@ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[2]! / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Work", desc: "In physics, a force is said to do work if, when acting on a body, there is a displacement of the point of application in the direction of the force. The work (z) is equal to the product of the force (x) and the distance (y).", type: .physics, expression: "@ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[2]! / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Potential energy", desc: "In physics, potential energy is the energy that an object has due to its position in a force field or that a system has due to the configuration of its parts. The potential energy (u) is equal to the product of the mass (x), the gravity (y) and the height (z). A common value for the gravity is 9.82m/s^2.", type: .physics, expression: "@ * @ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! / (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! * values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Kinetic energy", desc: "In physics, the kinetic energy of an object is the energy that it possesses due to its motion. The kinetic energy (z) is equal to the product of the mass (x) and the velocity (y).", type: .physics, expression: "(@ * @^2) / 2 = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return 2*values[2]! / pow(values[1]!, 2)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return sqrt(2*values[2]! / values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return 2*(values[0]! * pow(values[1]!, 2))
				}
			}
			return 0
		}),
		ABFormula(name: "Power", desc: "In physics, power is the rate of doing work. It is equivalent to an amount of energy consumed per unit time. The power (z) is equal to the qoutient of the amount of energy (x) and the time (t).", type: .physics, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Pressure", desc: "Pressure is the force applied perpendicular to the surface of an object per unit area over which that force is distributed. The pressure (z) is equal to the qoutient of the force (x) acting on the area and the area (y).", type: .physics, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Pressure in liquids", desc: "Pressure is the force applied perpendicular to the surface of an object per unit area over which that force is distributed. The pressure (u) in a liquid is equal to the product of the density (x), the gravity (y) and the height (z). Commonly the gravity is set to 9.81m/s^2.", type: .physics, expression: "@ * @ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! / (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! * values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Archimedes' Principle", desc: "Archimedes' Principle indicates that the upward bouyant force that is exerted on a body immersed in a fluid, whether fully or partially submerged is equal to the weight of the fluid that the body displaces. The bouyant force (u) is equal to the product of the density (x) of the fluid, the gravity (y) and the volume (z) which the body displaces.", type: .physics, expression: "@ * @ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (values[2]! * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return values[3]! / (values[0]! * values[1]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[2]! * values[0]! * values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "The combined gas law", desc: "The combined gas law or general gas equation is obtained by combining the three gas laws and shows the relationship between the pressure (x), volume (y) and temperature (z) for a fixed mass of gas. u is a constant.", type: .physics, expression: "@ * @ = @ * @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! * values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! * values[2]! / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return (values[0]! * values[1]!) / values[3]!
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return (values[0]! * values[1]!) / values[2]!
				}
			}
			return 0
		}),
		ABFormula(name: "Amount of substance", desc: "Amount of substance is a standards defined quantity that measures the size of an ensemble of elementary entities, such as, atoms, molecules, electrons, and other particles. It is sometimes referred to as chemical amount. The amount of substance (z) is equal to the qoutient of the mass (x) and the molarity (y).", type: .chemistry, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Concentration", desc: "In chemistry, concentration is the abundance of a constituent divided by the total volume of a mixture. The concentration (z) is equal to the qoutient of the amount of moles (x) and the volume (y).", type: .chemistry, expression: "@ / @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! * values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return values[0]! / values[2]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! / values[1]!
				}
			}
			return 0
		}),
		ABFormula(name: "Ideal gas law", desc: "The ideal gas law is the equation of the state of a hypothetical ideal gas. The equation shows the relationship between the product of the pressure (x) and the volume (y), and the product of the amount of moles (z), the ideal gas constant (u) and the temperature (v). The temperature is in kelvin.", type: .chemistry, expression: "@ * @ = @ * @ * @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					return values[4]! * values[3]! * values[2]! / values[1]!
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					return values[4]! * values[3]! * values[2]! / values[0]!
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil && values[4] != nil{
					return (values[0]! * values[1]!) / (values[4]! * values[3]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[4] != nil{
					return (values[0]! * values[1]!) / (values[4]! * values[2]!)
				}
			} else if values[4] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[3] != nil{
					return (values[0]! * values[1]!) / (values[3]! * values[2]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Velocity in the y-plane", desc: "Projectile motion is a form of motion experienced by an object or particle (a projectile) that is thrown near the Earth's surface and moves along a curved path under the action of gravity only (in particular, the effects of air resistance are assumed to be negligible). The velocity (v) in the y-plane is equal to the difference between the product of the initial velocity(x) and the angle(y), and the product of the gravity (z) and the time(u).", type: .physics, expression: "@ * sin(@) - @ * @ = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					return (values[4]! + values[3]! * values[2]!) / sin(values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					return asin((values[4]! + values[3]! * values[2]!) / values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil && values[4] != nil{
					return (values[0]! * sin(values[1]!) - values[4]!) / values[3]!
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[4] != nil{
					return (values[0]! * sin(values[1]!) - values[4]!) / values[2]!
				}
			} else if values[4] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[3] != nil{
					return (values[0]! * sin(values[1]!)) - (values[3]! * values[2]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Velocity in the x-plane", desc: "Projectile motion is a form of motion experienced by an object or particle (a projectile) that is thrown near the Earth's surface and moves along a curved path under the action of gravity only (in particular, the effects of air resistance are assumed to be negligible). The velocity (z) in the x-plane is equal to the product of the initial velocity(x) and the angle(y).", type: .physics, expression: "@ * cos(@) = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil{
					return values[2]! / cos(values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil{
					return acos(values[2]! / values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil{
					return values[0]! * cos(values[1]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Displacement in the x-plane", desc: "Projectile motion is a form of motion experienced by an object or particle (a projectile) that is thrown near the Earth's surface and moves along a curved path under the action of gravity only (in particular, the effects of air resistance are assumed to be negligible). The displacement (u) in the x-plane is equal to the product of the initial velocity (x), the time (y) and the angle (z).", type: .physics, expression: "@ * @ * cos(@) = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (cos(values[2]!) * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return values[3]! / (cos(values[2]!) * values[0]!)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return acos(values[3]! / (values[0]! * values[1]!))
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return values[0]! * values[1]! * cos(values[2]!)
				}
			}
			return 0
		}),
		ABFormula(name: "Displacement in the y-plane", desc: "Projectile motion is a form of motion experienced by an object or particle (a projectile) that is thrown near the Earth's surface and moves along a curved path under the action of gravity only (in particular, the effects of air resistance are assumed to be negligible). The displacement (v) in the y-plane is equal to the difference between the product of the initial velocity(x), the time(y), and the angle(z), and the product of the gravity (u) and the time(y).", type: .physics, expression: "@ * @ * sin(@) - (@ * y^2) / 2 = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					return (values[4]! + (values[3]! * pow(values[1]!,2))/2) / (sin(values[2]!) * values[1]!)
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil && values[4] != nil{
					//pq-formula to solve time (y)
					let p = -2*values[0]! * sin(values[2]!) / values[3]!
					let q = 2*values[4]! / values[3]!
					return (-p/2) - sqrt(pow((p/2),2) - q)
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil && values[4] != nil{
					return asin((values[4]! + (values[3]! * pow(values[1]!,2))/2) / (values[0]! * values[1]!))
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[4] != nil{
					return 2*(values[0]! * values[1]! * sin(values[2]!) - values[4]!) / pow(values[1]!,2)
				}
			} else if values[4] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil && values[3] != nil{
					return values[0]! * values[1]! * sin(values[2]!) - (values[3]! * pow(values[1]!, 2) / 2)
				}
			}
			return 0
		}),
		ABFormula(name: "Max height of projectile", desc: "Projectile motion is a form of motion experienced by an object or particle (a projectile) that is thrown near the Earth's surface and moves along a curved path under the action of gravity only (in particular, the effects of air resistance are assumed to be negligible). The maximum height (u) is equal to the qoutient between the product of the initial velocity(x) and the angle(y), and the gravity (z).", type: .physics, expression: "@^2 * sin(@)^2 / (2 * @) = @", formula: { (values) -> Double in
			if values[0] == nil{
				if values[1] != nil && values[2] != nil && values[3] != nil{
					return sqrt((values[3]! * 2 * values[2]!) / pow(sin(values[1]!),2))
				}
			} else if values[1] == nil{
				if values[0] != nil && values[2] != nil && values[3] != nil{
					return sqrt((values[3]! * 2 * values[2]!) / pow(values[0]!,2))
				}
			} else if values[2] == nil{
				if values[0] != nil && values[1] != nil && values[3] != nil{
					return pow(values[0]!, 2) * pow(sin(values[1]!),2) / (2*values[3]!)
				}
			} else if values[3] == nil{
				if values[0] != nil && values[1] != nil && values[2] != nil{
					return pow(values[0]!, 2) * pow(sin(values[1]!),2) / (2*values[2]!)
				}
			}
			return 0
		}),
		ABFormula(name: "PQ-formula", desc: "The pq-formula can be used to solve the equation x(u^2) + yu + z = 0. By setting p = y/x and q = z/x, you can solve for a using the following formula: u = -p/2 +/- sqrt((p/2)^2 - q).", type: .math, expression: "@ * (u^2) + @ * u + @ = 0 => u = @", formula: { (values) -> Double in
			if values[1] != nil && values[2] != nil && values[0] != nil{
				let p = values[1]! / values[0]!
				let q = values[2]! / values[0]!
				return (-p/2) + sqrt(pow((p/2),2) - q)
			}
			return 0
		}),
		ABConversionFormula(name: "Area", conversions: [
			ABConversionFormula.ConversionItem(name: "Square metres", value: 1.0),
			ABConversionFormula.ConversionItem(name: "Hectares", value: 10000.0),
			ABConversionFormula.ConversionItem(name: "Square KM", value: 1000000.0),
			ABConversionFormula.ConversionItem(name: "Square feet", value: 0.092903),
			ABConversionFormula.ConversionItem(name: "Square miles", value: 2589988.0),
			ABConversionFormula.ConversionItem(name: "Acres", value: 4046.856445),
			]),
		ABConversionFormula(name: "Length", conversions: [
			ABConversionFormula.ConversionItem(name: "Meter", value: 1.0),
			ABConversionFormula.ConversionItem(name: "Millimeter", value: 0.001),
			ABConversionFormula.ConversionItem(name: "Centimeter", value: 0.01),
			ABConversionFormula.ConversionItem(name: "Decimeter", value: 0.1),
			ABConversionFormula.ConversionItem(name: "Kilometer", value: 1000.0),
			ABConversionFormula.ConversionItem(name: "Inch", value: 0.0254),
			ABConversionFormula.ConversionItem(name: "Foot", value: 0.3048),
			ABConversionFormula.ConversionItem(name: "Yard", value: 0.91440),
			ABConversionFormula.ConversionItem(name: "Mile", value: 1690.343994),
			]),
		ABConversionFormula(name: "Volume", conversions: [
			ABConversionFormula.ConversionItem(name: "Liter", value: 1.0),
			ABConversionFormula.ConversionItem(name: "Mililiter", value: 0.001),
			ABConversionFormula.ConversionItem(name: "Centiliter", value: 0.01),
			ABConversionFormula.ConversionItem(name: "Deciliter", value: 0.1),
			ABConversionFormula.ConversionItem(name: "Fluid ounce", value: 0.028),
			ABConversionFormula.ConversionItem(name: "Pint", value: 0.568),
			ABConversionFormula.ConversionItem(name: "Quart", value: 1.136),
			ABConversionFormula.ConversionItem(name: "Gallon", value: 4.546),
			]),
		ABConversionFormula(name: "Custom", conversions: [
			ABConversionFormula.ConversionItem(name: "1.0", value: 1.0),
			ABConversionFormula.ConversionItem(name: "0.1", value: 0.1),
			ABConversionFormula.ConversionItem(name: "0.25", value: 0.25),
			ABConversionFormula.ConversionItem(name: "0.5", value: 0.5),
			ABConversionFormula.ConversionItem(name: "0.75", value: 0.75),
			ABConversionFormula.ConversionItem(name: "2.0", value: 2.0),
			ABConversionFormula.ConversionItem(name: "3.0", value: 3.0),
			ABConversionFormula.ConversionItem(name: "4.0", value: 4.0),
			ABConversionFormula.ConversionItem(name: "5.0", value: 5.0),
			ABConversionFormula.ConversionItem(name: "10.0", value: 10.0),
			ABConversionFormula.ConversionItem(name: "20.0", value: 20.0),
			ABConversionFormula.ConversionItem(name: "50.0", value: 50.0),
			ABConversionFormula.ConversionItem(name: "100.0", value: 100.0),
			]),
		ABConversionFormula(name: "Weight", conversions: [
			ABConversionFormula.ConversionItem(name: "Gram", value: 1.0),
			ABConversionFormula.ConversionItem(name: "Milligram", value: 0.001),
			ABConversionFormula.ConversionItem(name: "Hectogram", value: 100.0),
			ABConversionFormula.ConversionItem(name: "Kilogram", value: 1000.0),
			ABConversionFormula.ConversionItem(name: "Metric ton", value: 1000000.0),
			ABConversionFormula.ConversionItem(name: "Grain", value: 0.064799),
			ABConversionFormula.ConversionItem(name: "Ounce", value: 28.349524),
			ABConversionFormula.ConversionItem(name: "Pound", value: 453.592377),
			ABConversionFormula.ConversionItem(name: "Quarter", value: 12700.585938),
			ABConversionFormula.ConversionItem(name: "Imperial ton", value: 1016046.937500),
			])
	]
}
