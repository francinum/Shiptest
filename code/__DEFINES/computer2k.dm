//UNUSED
#define PLUGGABLE_SLOT_CPU "cpu"               // Main Processor. Only one.
#define PLUGGABLE_SLOT_BIOSROM "biosrom"       // Fixed disk. Holds the BIOS. Only one.
#define PLUGGABLE_SLOT_RTC "rtc"               // Realtime Clock, also holds BIOS long term memory. Only one.
#define PLUGGABLE_SLOT_ISA "isa"               // Basic peripheral cards. Fair amount of slots.
#define PLUGGABLE_SLOT_PCI "pci"               // More advanced cards. Less slots.

#define PLUGFAIL_SLOTS_FULL -1
#define PLUGFAIL_NO_SLOT    -2

// DRIVE RETURN VALUES
#define ERR_STORAGE_FULL 1
