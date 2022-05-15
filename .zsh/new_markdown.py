import argparse
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Optional


@dataclass(frozen=True)
class NewMarkdownFile:
    path: Path
    kernel: Optional[str] = None

    def set_kernel(self):

        assert self.kernel, "Kernel not specified in input."

        subprocess.run(["jupytext", "--set-kernel", str(self.kernel), str(self.path)])

    def set_types(self):

        subprocess.run(["jupytext", "--set-formats", "myst,ipynb", str(self.path)])

    def main(self):

        # make the parent dirs
        if not (parent := self.path.parent).exists():
            parent.mkdir(parents=True, exist_ok=True)

        # make the file
        try:
            self.path.touch(exist_ok=False)
        except FileExistsError:
            print("Error: file already exists.")
            sys.exit(1)

        # set its type
        self.set_types()

        if self.kernel:
            self.set_kernel()


if __name__ == "__main__":

    parser = argparse.ArgumentParser("new markdown")
    parser.add_argument(
        "--path",
        metavar="PATH",
        help="filepath of the markdown file. Must end with the .md extension.",
    )
    parser.add_argument(
        "--kernel", "-k", metavar="KERNEL", help="Name of jupyter kernel to set."
    )

    args = parser.parse_args()

    path = args.path
    if path is None:
        try:
            path = input("Path to the new myst markdown file: ")
            kernel = input("Name of kernel to execute with: ")
        except KeyboardInterrupt:
            sys.exit(1)

    path = Path(path)

    if path.suffix != ".md":
        print("Error: must supply a markdown filepath.")
        sys.exit(1)

    kernel = _ker if (_ker := args.kernel) else kernel

    NewMarkdownFile(path=path, kernel=kernel).main()
