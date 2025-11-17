import requests
import re

def fetch_gtfobins():

    print("getting gtfobins lists ffs")
    
    r = requests.get("https://github.com/GTFOBins/GTFOBins.github.io/tree/master/_gtfobins")
    bins = re.findall(r'_gtfobins/([a-zA-Z0-9_ \-]+).md', r.text)
    
    sudoVB = []
    suidVB = []
    capsVB = []

    for b in bins:
        try:
            rb = requests.get(f"https://raw.githubusercontent.com/GTFOBins/GTFOBins.github.io/master/_gtfobins/{b}.md", timeout=7)
        except:
            print("a load failed this time")
            continue
            
        if "sudo:" in rb.text:
            if len(b) <= 3:
                sudoVB.append("[^a-zA-Z0-9]"+b+"$")  
            else:
                sudoVB.append(b+"$")
        if "suid:" in rb.text:
            suidVB.append("/"+b+"$")
        if "capabilities:" in rb.text:
            capsVB.append(b)
    
    return suidVB, sudoVB, capsVB

def generate_shell_variables(suidVB, sudoVB, capsVB):
    print("trying to shove it in shell")
    
    # # suidVB1 = suidVB[:len(suidVB)//2]
    # # suidVB2 = suidVB[len(suidVB)//2:]
    # # sudoVB1 = sudoVB[:len(sudoVB)//2] 
    # sudoVB2 = sudoVB[len(sudoVB)//2:]
    
    shell_script = f"""#!/bin/bash
# Auto-generated GTFOBins patterns
export sidVB='{"|".join(suidVB)}'
export sudVB='{"|".join(sudoVB)}'
export capsVB='{"|".join(capsVB)}'
export capsVB2='{"|".join(capsVB)}'

echo "gtfobins :"
echo "    SUID: ${{#suidVB}} + ${{#suidVB2}} patterns"
echo "    SUDO: ${{#sudoVB}} + ${{#sudoVB2}} patterns" 
echo "    CAPS: ${{#capsVB}} patterns"
"""
    return shell_script

if __name__ == "__main__":
    suidVB, sudoVB, capsVB = fetch_gtfobins()
    
    shell_code = generate_shell_variables(suidVB, sudoVB, capsVB)
    
    # Write to file
    with open("gtfobins_variables.sh", "w") as f:
        f.write(shell_code)