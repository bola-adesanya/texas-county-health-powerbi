"""
Validate that yearly Texas county health CSV files contain the minimum fields
needed for the Power BI dashboard.

Expected Files:
- data/raw/Data File for Texas Health Facts 2006.csv
- data/raw/Data File for Texas Health Facts 2007.csv
- data/raw/Data File for Texas Health Facts 2008.csv
- data/raw/Data File for Texas Health Facts 2009.csv                       

Usage:
    python scripts/validate_schema.py data/raw
"""

from __future__ import annotations

import csv
import sys
from pathlib import Path

REQUIRED_COLUMNS = {
    "CNTY",
    "CONAME",
    "TOTPOP",
    "POPANGPC",
    "POPBLPCT",
    "POPHISPC",
    "POPOTHPC",
    "POPTFMPC",
    "POPTMPC",
    "HRTDEART",
    "LNGCANDR",
    "MVDEART",
    "SUIDEART",
    "FSPARTIC",
    "POVTOT",
    "LIVEBIR",
    "LBWNO",
    "NOHI1864",
    "NOHI1864POP",
    "PERTNO",
    "PERTRATE",
    "TBNO",
    "SYPHNO",
    "GONNO",
    "CHLAMNO",
    "VARICNO",
    "AIDSNO",
}


def read_header(csv_path: Path) -> set[str]:
    with csv_path.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.reader(f)
        return {col.strip() for col in next(reader)}


def validate_folder(folder: Path) -> int:
    csv_files = sorted(folder.glob("*.csv"))
    if not csv_files:
        print(f"No CSV files found in {folder}")
        return 1

    exit_code = 0
    for path in csv_files:
        header = read_header(path)
        missing = sorted(REQUIRED_COLUMNS - header)
        if missing:
            exit_code = 1
            print(f"FAIL: {path.name}")
            print("  Missing columns:")
            for col in missing:
                print(f"  - {col}")
        else:
            print(f"PASS: {path.name}")

    return exit_code


if __name__ == "__main__":
    folder_arg = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("data/raw")
    raise SystemExit(validate_folder(folder_arg))
