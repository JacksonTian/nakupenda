'use strict';

const fs = require('fs');
const path = require('path');

var section = Buffer.alloc(512);

// The initial three bytes, in hexadecimal as 0xe9, 0xfd and 0xff,
// are actually machine code instructions, as defined by the CPU manufacturer,
// to perform an endless jump.
section.writeUInt8(0xe9, 0);
section.writeUInt8(0xfd, 1);
section.writeUInt8(0xff, 2);

// The last two bytes, 0x55 and 0xaa, make up the magic number,
// which tells BIOS that this is indeed a boot block and not just data
// that happens to be on a drive’s boot sector.
section.writeUInt8(0x55, 510);
section.writeUInt8(0xaa, 511);

var output = path.join(__dirname, 'boot.bin');
fs.writeFile(output, section, function (err) {
  if (err) {
    console.log(err.stack);
    return;
  }
  console.log('generated at: %s', output);
});
