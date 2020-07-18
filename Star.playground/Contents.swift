//: Author: Evan Putnam emp9173@rit.edu
//:
//: Description: A visualization of the known universe using
//: the HYG star database.
//:     Dataset - https://github.com/astronexus/HYG-Database
//:
//: User starts from the perspective of earth and can walk through
//: the universe.
//:
//:Notes: There is a variable that you can change to adjust the percentage of stars being rendered.  It does take a little while to load due to the large nature of the data set.  It may look like it is hanging on the stars but it is not.  It is just loading.
//:

import UIKit
import Foundation
import SceneKit
import PlaygroundSupport
import ARKit



/**
 * Handles the loading of the ui view controller
 */
class SpaceViewController: UIViewController{
    
    /**
    * Number of stars to modulo.  1 is all, 2 is 1/2, etc.
    * This is limited by default because has
    * trouble rendering all of the items
    */
    private let MOD_VAL = 4
    
    /**
    * Generates all the stars and adds them to the scene
    */
    private func sceneInit(scene :SCNScene){
        
        //Create the star generator and add the shapes (limits)
        let gen = StarGenerator()
        gen.addShapes(rad: 0.005, starGen: gen, scene: scene, limitMod: MOD_VAL)
    }
    
    /**
    * Setup the view and config ar settings
    */
    private func initView(view: ARSCNView){
        //View handling
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        //AR config
        let arConfig = ARWorldTrackingConfiguration()
        view.session.run(arConfig, options: [.removeExistingAnchors,.resetTracking])
        
        //UI color to black
        view.scene.background.contents = UIColor.black
    }

    
    

    /**
     Loads the view for the display
    */
    override func loadView() {
        //Create scene obj
        let scene = SCNScene()
        sceneInit(scene: scene)

        //Create the view
        let view = ARSCNView()
        initView(view: view)
        view.scene = scene
        
        //Set background to black
        scene.background.contents = UIColor.black;
        
        //Get camera and set props
        let camera = view.pointOfView!.camera!
        camera.fStop = 2.8
        camera.zFar = 700
        
        //Set cameraNode
        let cameraNode = view.pointOfView!
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x:0.0, y:0.0, z:0.0)
        
        //Add camera node to scene
        scene.rootNode.addChildNode(cameraNode)
        
        //Set the view
        self.view = view
        
    }

}

print("Got here")
let spaceView = SpaceViewController()
PlaygroundPage.current.liveView = spaceView
print("Got here2")

























