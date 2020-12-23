import re
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--bnlearn_string', dest='bnlearn_string', default='[test]', help='bnlearn string')
args = parser.parse_args()

bnlearn_string = args.bnlearn_string

# Split all network nodes and remove first element since this is always an empty array
nodes = bnlearn_string.split("[")
del nodes[0]

node_parent_dict = {}
for node in nodes:

    # Split node from parents using the delimeter used by bnlearn
    child_parent_split = node.split("|")
    
    # Add nodes + parents (if any) to dictionary
    if len(child_parent_split) == 2:
        target = child_parent_split[0]
        parents = child_parent_split[1]

        parent_list = []
        for parent in parents.split(":"):
            parent_list.append(re.search("[a-zA-Z]+(?:_[a-zA-Z]+)*", parent).group(0))
        node_parent_dict[target] = parent_list

    else:
        node = re.search("[a-zA-Z]+(?:_[a-zA-Z]+)*", node).group(0)
        node_parent_dict[node] = []

# Construct dagitty string
dagitty_string = "dag { "

# First add all "root" nodes to the dagitty string
dagitty_string += " ".join(node_parent_dict.keys())

# Add all parent connections to the dagitty string
for root, parents in node_parent_dict.items():
    if len(parents) > 0:
        for parent in parents:
            dagitty_string += " {} -> {}".format(parent, root)

dagitty_string += " }"


# Print result
print(dagitty_string)