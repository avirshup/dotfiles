#!/usr/bin/env python
import plistlib
from pathlib import Path
import sys

OFFSET = 0xE000
BAD_CODES = {1, 5, 0x1B}

DEFAULTS = Path(__file__).parent / "term-defaults.xml"


def read_plist(p: Path) -> dict:
    escaped = "".join(
        (chr(ord(char) + OFFSET) if ord(char) in BAD_CODES else char)
        for char in p.read_text()
    )
    return plistlib.loads(escaped.encode("utf-8"))


def write_plist(plist: dict, p: Path):
    final_text = "".join(
        (chr(ord(char) - OFFSET) if ord(char) > OFFSET else char)
        for char in plistlib.dumps(plist).decode("utf-8")
    )
    p.write_text(final_text)


def main():
    base = read_plist(DEFAULTS)

    out_dir = Path("./merged")
    out_dir.mkdir(exist_ok=True)

    for f in sys.argv[1:]:
        source = Path(f)
        target = out_dir / source.name

        new = read_plist(source)
        merged = new | base
        write_plist(merged, target)
        print(target)


if __name__ == "__main__":
    main()
