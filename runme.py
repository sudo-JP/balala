import json
import os
import subprocess

def main():
    subprocess.Popen(
        ["rojo", "serve"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    subprocess.Popen(
        ["rojo", "sourcemap", "--watch", "sourcemap.json"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    print("started processes")


if __name__ == "__main__":
    main()
