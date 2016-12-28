#if __APPLE__
  #if __arm__
    #include "libs/context/src/asm/make_arm_aapcs_macho_gas.S"
  #elif __arm64__
    #include "libs/context/src/asm/make_arm64_aapcs_macho_gas.S"
  #else
    // Other kinds of macOS or iOS Simulator
    #include "libs/context/src/asm/make_combined_sysv_macho_gas.S"
  #endif
#elif __linux__
  #if __arm__
    #include "libs/context/src/asm/make_arm_aapcs_elf_gas.S"
  #elif __arm64__
    #include "libs/context/src/asm/make_arm64_aapcs_elf_gas.S"
  #elif __i386__
    #include "libs/context/src/asm/make_i386_sysv_elf_gas.S"
  #elif __x86_64__
    #include "libs/context/src/asm/make_x86_64_sysv_elf_gas.S"
  #else
    #error "Unknown platform"
  #endif
#endif
