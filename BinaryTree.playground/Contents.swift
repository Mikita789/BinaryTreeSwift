import UIKit

enum NodeType{
    case red
    case black
}

class NodeBinaryTree{
    var value:Int
    var left: NodeBinaryTree?
    var right: NodeBinaryTree?
    
    var color: NodeType = .red
    
    init(value: Int) {
        self.value = value
    }
}

class BinaryTree{
    var root: NodeBinaryTree?
    var isEmpty:Bool{
        root == nil
    }
}

extension BinaryTree{
    func insertEl(value:Int){
        if root != nil{
            self.addElement(value: value, currentNode: root!)
        }else{
            let node = NodeBinaryTree(value: value)
            node.color = .black
            self.root = node
        }
    }
    private func addElement(value:Int, currentNode: NodeBinaryTree){
        if currentNode.value == value{
            print("такой элемент уже есть")
        }else{
            if value < currentNode.value{
                if let left = currentNode.left{
                    addElement(value: value, currentNode: left)
                }else{
                    let node = NodeBinaryTree(value: value)
                    currentNode.left = node
                    fixColor(currentNode: node)
                }
            }else if value > currentNode.value{
                if let right = currentNode.right{
                    addElement(value: value, currentNode: right)
                }else {
                    let node = NodeBinaryTree(value: value)
                    currentNode.right = node
                    fixColor(currentNode: node)
                }
            }
        }
    }
    
    func searchElement(value: Int)->Bool{
        var flag = false
        if root != nil{
            flag = searchElementBack(value: value, currentNode: root!)
        }else{
            print("Дерево путое")
        }
        return flag
    }
    
    private func searchElementBack(value: Int, currentNode: NodeBinaryTree)-> Bool{
        
        
        if currentNode.value == value{
            return true
        }else if value < currentNode.value{
            if let left = currentNode.left{
                return searchElementBack(value: value, currentNode: left)
            }
        }else if value > currentNode.value{
            if let right = currentNode.right{
                return searchElementBack(value: value, currentNode: right)
            }
        }
        return false
    }
    
    private func swapColor(node: NodeBinaryTree){
        if node.color == .red{
            node.color = .black
        }else{
            node.color = .red
        }
    }
    
    private func fixColor(currentNode: NodeBinaryTree){
        if currentNode.value == root?.value{
            currentNode.color = .black
        }else if currentNode.color == .red && currentNode.left?.color == .red{
            if currentNode.right?.color == .red{
                swapColor(node: currentNode)
            }else {
                if currentNode.left?.color == .red{
                    rotateRight(currentNode: currentNode)
                    swapColor(node: currentNode)
                }
            }
        }
    }
    
    private func rotateRight(currentNode: NodeBinaryTree) {
        guard let leftChild = currentNode.left else {
            return
        }
        
        currentNode.left = leftChild.right
        leftChild.right = currentNode
        if currentNode.value == root?.value {
            root = leftChild
        }
    }
}


var bt = BinaryTree()

bt.insertEl(value: 10)
print(bt.root?.value)
print(bt.root?.color)
bt.insertEl(value: 20)
print(bt.root?.right?.value)
print(bt.root?.right?.color)

