import sys
def run(path):
    with open(path, 'r', encoding='utf-8') as f:
        code = [c for c in f.read() if c in '><+-.,[]']
    loop, stack = {}, []
    for i, c in enumerate(code):
        if c == '[': stack.append(i)
        elif c == ']': start = stack.pop(); loop[start], loop[i] = i, start
    cells, ptr, pc, out = [0]*30000, 0, 0, bytearray()
    while pc < len(code):
        c = code[pc]
        if c == '>': ptr += 1
        elif c == '<': ptr -= 1
        elif c == '+': cells[ptr] = (cells[ptr] + 1) % 256
        elif c == '-': cells[ptr] = (cells[ptr] - 1) % 256
        elif c == '.': out.append(cells[ptr])
        elif c == '[' and cells[ptr] == 0: pc = loop[pc]
        elif c == ']' and cells[ptr] != 0: pc = loop[pc]
        pc += 1
    sys.stdout.buffer.write(out)
if __name__ == '__main__': run(sys.argv[1])
