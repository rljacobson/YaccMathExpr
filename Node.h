//
//  Node.h
//  
//
//  Created by Robert Jacobson on 2/14/15.
//
//

#ifndef ____Node__
#define ____Node__

#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Node{
public:
    string name;
    vector<Node*> children;
    void PrintPretty(string indent, bool last);
    Node(string n, Node *child1, Node *child2);
};



#endif /* defined(____Node__) */
