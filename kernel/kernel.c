#include "../drivers/screen.h"

void kernel_main() {
    clear_screen();
    kprint_at("ABC", 0, 0);
    kprint_at("B", 1, 7);
    kprint_at("This ", 75, 10);
    kprint_at("There is a line\nbreak", 0, 20);
    kprint("There is a line\nbreak");
    kprint_at("What happens when we run out of space?", 45, 24);
}
