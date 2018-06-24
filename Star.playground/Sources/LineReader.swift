import Foundation

/**
 * Class that is used to read line by line in a file
 */
public class LineReader{
    
    //File path to search
    let filePath: String
    
    //C style file pointer
    let file: UnsafeMutablePointer<FILE>!
    
    /**
    * Initializes the filePath and creates a C file data member
    */
    public init(filePath: String) {
        self.filePath = filePath
        self.file = fopen(filePath, "r")
    }
    
    /**
    * Variable that is used to get the next line in the file.
    */
    public var getLine: String?{
        //Char pointer
        var line:UnsafeMutablePointer<CChar>? = nil;
        var c: Int = 0
        //Get line and write to pointer
        let gL = getline(&line, &c, file)
        //If sussessful
        if(gL > 0){
            //Set string to return
            let lineG:String = String(cString: line!);
            //Free used memory
            free(line)
            return lineG
        }else{
            free(line)
            return nil;
        }
    }
    
    /**
    * Closes the open file.
    */
    public func cleanUp(){
        fclose(file);
    }
    
}


