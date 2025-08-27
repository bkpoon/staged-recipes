def run():
  with open('SConstruct', 'r') as f:
    lines = f.readlines()
  with open('SConstruct', 'w') as f:
    for line in lines:
      line = line.strip()
      # add dxtbx SConscript for dxtbx includes
      if 'spotfinder' in line:
        f.write('SConscript("dxtbx/SConscript")')
        f.write('\n')
      if 'prime' in line:
        continue
      f.write(line)
      f.write('\n')

if __name__ == '__main__':
  run()
