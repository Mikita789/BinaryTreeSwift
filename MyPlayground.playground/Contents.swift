import UIKit

class TreeNode<Element> {
    var value: Element
    var childred: [TreeNode] = []
    
    init(value:Element) {
        self.value = value
    }
    
    func addCh(value: TreeNode){
        self.childred.append(value)
    }
}

extension TreeNode{
    func printElements(context: (TreeNode)-> ()){
        context(self)
        self.childred.forEach{ $0.printElements(context: context)}
    }
    
    func printLevelElements(context: (TreeNode)->()){
        context(self)
        var q = Queu<TreeNode>()
        
        self.childred.forEach{q.addElement(value: $0)}
        while let node = q.removeElement(){
            context(node)
            node.childred.forEach{q.addElement(value: $0)}
        }
    }
}


var tree = TreeNode(value: "Catalog")
var sh = TreeNode(value: "Shoes")
var manSh = TreeNode(value: "Man Shoes")
var womanSh = TreeNode(value: "Woman Shoes")
sh.addCh(value: manSh)
sh.addCh(value: womanSh)

var shirts = TreeNode(value: "Shirts")
tree.addCh(value: sh)
tree.addCh(value: shirts)

var blackShirts = TreeNode(value: "Black Shirts")
var pinkShirts = TreeNode(value: "Pink Shirts")
shirts.addCh(value: blackShirts)
shirts.addCh(value: pinkShirts)

tree.printElements { node in
    print(node.value)
}
print()
tree.printLevelElements { node in
    print(node.value)
}





class Queu<Element>{
    var first: Element?
    var last: Element?
    var isEmpty:Bool{ self.arrElements.isEmpty }
    
    
    private var arrElements: [Element] = []
    
    func addElement(value:Element){
        self.arrElements.append(value)
    }
    func removeElement() -> Element? {
        guard !self.arrElements.isEmpty else { return nil }
        return self.arrElements.removeFirst()
    }
}
