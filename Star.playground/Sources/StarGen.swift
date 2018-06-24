import Foundation
import UIKit
import Foundation
import SceneKit
import PlaygroundSupport


/**
 * Star class that holds the information for
 * a star in the HYG database
 */
public class Star{
    public var x: Float;
    public var y: Float;
    public var z: Float;
    init(x: Float, y: Float, z: Float){
        self.x = x;
        self.y = y;
        self.z = z;
    }
}

/**
 * Generator class that stores stars in an array
 */
public class StarGenerator{
    
    //Array to store the stars.
    public var stars = [Star]();
    
    //File in resources to pull the data from
    let fileURL = Bundle.main.url(forResource: "starsNew", withExtension: "csv")!
    
    /**
    * Fill the stars array with items from the .csv file
    */
    public init() {
        let lReader:LineReader = LineReader(filePath: fileURL.path)
        
        while(true){
            if let x = lReader.getLine{
                var xyz = x.components(separatedBy: ",")
                xyz[2] = xyz[2].trimmingCharacters(in: .whitespacesAndNewlines)
                
                stars.append(
                    Star(x:Float(xyz[0])!,y:Float(xyz[1])!, z:Float(xyz[2])!)
                )
                
            }else{
                break
            }
        }
        
        print("done!")
        
        lReader.cleanUp();
    }
    
    /**
    *   Gets a random brightness value for the star.
    */
    private func randomBright(min:Int, max:Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    /**
    * Add all the stars the current scene.
    * Has the option to limit the number of stars for mobile devices
    */
    public func addShapes(rad: CGFloat, starGen:StarGenerator, scene: SCNScene, limitMod:Int){
        
        var iter: Int = 0
        for star in self.stars {
            //This line here limits the database to a fourth size
            if(iter%limitMod==0){
                let g = SCNSphere(radius:rad)
                let material = SCNMaterial()
                material.lightingModel = .blinn
                material.multiply.contents = UIColor(red: 0.4,
                                                     green: (CGFloat(randomBright(min:40, max:200)))/255.0,
                                                     blue: 1.0,
                                                     alpha: 1)
                material.emission.contents = material.multiply.contents
                g.materials = [material]
                let node = SCNNode(geometry:g)
                node.position = SCNVector3(x: star.x/20, y: star.y/20, z: star.z/20)
                scene.rootNode.addChildNode(node)
            }
            iter += 1
        }
        //Resets so garbage collector should pick up old array
        self.stars = [Star]();
        
        
    }
    

}

