import re

def parse_automaton(file_path):
    # Regular expressions based on the provided BNF rules
    nonfinal_state_re = r'\b([a-zA-Z]+)\b'
    final_state_re = r'\((?P<final>[a-zA-Z]+)\)'
    symbol_re = r'\((?P<symbol>[a-zA-Z])\)->'
    transition_re = r'(?P<from_state>\(?[a-zA-Z]+\)?)\s*\((?P<symbol>[a-zA-Z])\)->\s*(?P<to_state>\(?[a-zA-Z]+\)?)'

    states = set()
    final_states = set()
    alphabet = set()
    transitions = []

    with open(file_path, 'r') as file:
        for line in file:
            # Match final states
            final_match = re.search(final_state_re, line)
            if final_match:
                final_state = final_match.group("final")
                states.add(final_state)
                final_states.add(final_state)
            
            # Match non-final states
            else:
                nonfinal_match = re.search(nonfinal_state_re, line)
                if nonfinal_match:
                    nonfinal_state = nonfinal_match.group(0)
                    states.add(nonfinal_state)
            
            # Match transitions
            transition_match = re.search(transition_re, line)
            if transition_match:
                from_state = transition_match.group("from_state").strip("()")
                to_state = transition_match.group("to_state").strip("()")
                symbol = transition_match.group("symbol")

                # Add states and symbols
                states.update([from_state, to_state])
                alphabet.add(symbol)
                
                # Store the transition
                transitions.append((from_state, symbol, to_state))

    # Display results
    print("Set of States:", states)
    print("Alphabet:", alphabet)
    print("Transitions:")
    for transition in transitions:
        print(f"{transition[0]} --({transition[1]})--> {transition[2]}")
    print("Set of Final States:", final_states)

# Call the function with the path to the uploaded file
parse_automaton('/mnt/data/automaton_spec.txt')