//
//  Node.cpp
//  
//
//  Created by Robert Jacobson on 2/14/15.
//
//

#include "Node.h"

void Node::PrintPretty(string indent, bool last){
    cout << indent;
    if (last)
    {
        cout << "└─"; // "`";
        indent.append("  ");
    }
    else
    {
        cout << "├─"; // "|- "
        indent.append("| ");      //("| ");
    }
    cout << name << endl;
    
    for (int i = 0; i < children.size(); i++)
        children[i]->PrintPretty(indent, i == children.size() - 1);
}

Node::Node(string n, Node *child1, Node *child2): name(n)
{
    if(child1) children.push_back(child1);
    if(child2) children.push_back(child2);
}