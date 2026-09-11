import json
import os
import subprocess

PROCESS_JSON = "process.json"


def load_processes():
    if not os.path.exists(PROCESS_JSON):
        return {}

    if os.path.getsize(PROCESS_JSON) == 0:
        return {}

    try:
        with open(PROCESS_JSON, "r") as file:
            return json.load(file)
    except (json.JSONDecodeError, OSError):
        return {}


def save_processes(data):
    with open(PROCESS_JSON, "w") as file:
        json.dump(data, file, indent=4)


def kill_process(pid):
    subprocess.run(
        ["taskkill", "/F", "/T", "/PID", str(pid)],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def main():
    data = load_processes()

    if "serve" in data and "sourcemap" in data:
        kill_process(data["serve"])
        kill_process(data["sourcemap"])

        save_processes({})

        print("ended processes")
        return

    serve_proc = subprocess.Popen(
        ["rojo", "serve"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    sourcemap_proc = subprocess.Popen(
        ["rojo", "sourcemap", "--watch", "sourcemap.json"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    save_processes({
        "serve": serve_proc.pid,
        "sourcemap": sourcemap_proc.pid,
    })

    print("started processes")


if __name__ == "__main__":
    main()
