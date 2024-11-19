import re
import typing
import sys

class FiniteAutomaton:
    def __init__(self):
        self.states = set()
        self.initial_state = None
        self.final_states = set()
        self.transitions = {}
        self.alphabet = set()

    def add_state(self, state: str):
        self.states.add(state)

    def set_initial_state(self, state: str):
        """Dai set la state-u initial"""
        if state not in self.states:
            self.add_state(state)
        self.initial_state = state

    def add_final_state(self, state: str):
        """Gaseste final stateuriele si adaugarle"""
        if state not in self.states:
            self.add_state(state)
        self.final_states.add(state)

    def add_transition(self, from_state: str, symbol: str, to_state: str):
        """Fa asta si la tranzitii"""
        if from_state not in self.states:
            self.add_state(from_state)
        if to_state not in self.states:
            self.add_state(to_state)
        
        if from_state not in self.transitions:
            self.transitions[from_state] = {}
        
        if symbol in self.transitions[from_state]:
            raise ValueError(f"Nu poti sa ai 2 tranzitii de la state-ul {from_state} tot cu simbolul {symbol}!!!!")
        
        self.transitions[from_state][symbol] = to_state
        self.alphabet.add(symbol)

    def parse(self, input_text: str):
        """Aici plecam de la definitie"""
        #scoatem whitespaceu
        input_text = re.sub(r'#.*', '', input_text)
        input_text = re.sub(r'\s+', ' ', input_text).strip()

        # stateuri finale
        final_states_match = re.search(r'final states\s*=\s*{([^}]*)}', input_text)
        if final_states_match:
            final_states = [state.strip() for state in final_states_match.group(1).split(',')]
            for state in final_states:
                self.add_final_state(state)

        # trnazitii
        transition_matches = re.findall(r'(\w+)\s*\((\w)\)\s*->\s*(\w+)', input_text)
        for from_state, symbol, to_state in transition_matches:
            self.add_transition(from_state, symbol, to_state)

        # finalele
        if transition_matches and self.initial_state is None:
            self.set_initial_state(transition_matches[0][0])

    def validate(self):
        """Ba siguur e bine????"""
        if not self.initial_state:
            raise ValueError("N-avem initial stateuri for some reason")
        
        if not self.final_states:
            raise ValueError("Veiz ca n-ai pus final stateuri")
        
        for from_state, transitions in self.transitions.items():
            for symbol, to_state in transitions.items():
                if from_state not in self.states or to_state not in self.states:
                    raise ValueError(f"Nu prea are sens tranzitia simcer: {from_state} --({symbol})--> {to_state}")

    def accepts(self, input_string: str) -> bool:
        """
        Verificata daca stirngue acceptat de finita auomata
        
        Args:
            input_string (str): UN string din limbaju sjemejkr
        
        Returns:
            bool: True daca da, False daca nu lol 
        """

        #il folosesc in dfs
        def matches_regex(current_state, symbol: str) -> bool:
            for symbol_or_regex in self.transitions[current_state]:
                if re.match(symbol_or_regex, symbol):
                    return True
            return False
            
        #facem cu depth first search in FA
        def dfs(current_state: str, remaining_input: str) -> bool:
            # Daca nu mai avem input l-am consmat, vezi daca suntem intr-un final state
            if not remaining_input:
                return current_state in self.final_states
            
            # ia urmatoru simbol
            current_symbol = remaining_input[0]
            
            # Vezi daca ai unde sa te duci cu simbolu asta 
            if current_state in self.transitions and current_symbol in self.transitions[current_state] or matches_regex(current_state, current_symbol):
                next_state = self.transitions[current_state][current_symbol]
                return dfs(next_state, remaining_input[1:])
            
            # nup n-avem niciuna buna
            return False
        
        return dfs(self.initial_state, input_string)

    def __str__(self):
        """Putem sa-l vedem mai frumusel asa"""
        output = []
        output.append(f"State initial: {self.initial_state}")
        output.append(f"State-uri finale: {', '.join(self.final_states)}")
        output.append(f"Multimea tuturor statelor: {', '.join(sorted(self.states))}")
        output.append(f"Alfabetul: {', '.join(sorted(self.alphabet))}")
        output.append("Tranzitiile:")
        for from_state, transitions in self.transitions.items():
            for symbol, to_state in transitions.items():
                output.append(f"  {from_state} --({symbol})--> {to_state}")
        return "\n".join(output)

def main():
    # citeste din fisieru din argumentu 1 cli
    file = open(sys.argv[1], "r")
    
    try:
        fa = FiniteAutomaton()
        fa.parse(file.read())
        
        # just to be fs
        fa.validate()
        
        print(fa)

        print(f'\n avem fisieru {sys.argv[2]} \n')

        file_text = open(sys.argv[2], "r").read()

        print(f'cu textu \n{file_text}\n')

        print(f'{"DAA!!" if fa.accepts(file_text) else "NUUU!!"} e matchh!!!\n')
        
    
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    main()