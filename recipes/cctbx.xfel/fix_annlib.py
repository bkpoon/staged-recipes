from pathlib import Path

def run():
  sconscript_files = [Path('.') / 'SConscript', Path('.') / 'mono_simulation' / 'SConscript']
  for sconscript in sconscript_files:
    with open(sconscript, 'r') as f:
      lines = f.readlines()
    with open(sconscript, 'w') as f:
      for line in lines:
        line = line.rstrip()
        if '"ann"' in line:
          line.replace('"ann"', '"ann_cctbx"')
        f.write(line)
        f.write('\n')

if __name__ == '__main__':
  run()
