import subprocess
import json 
import os

PROCESS_JSON = "process.json"

def main():
    data = {}
    serve = "serve"
    sourcemap = "sourcemap"

    if os.path.exists(PROCESS_JSON) and os.path.getsize(PROCESS_JSON) > 0:
        try:
            with open(PROCESS_JSON, "r") as file:
                data = json.load(file)
        except json.JSONDecodeError:
            data = {}

    if serve in data: 
        serve_id = data[serve]
        sourcemap_id = data[sourcemap]
        
        kill_process = lambda s: subprocess.run(f"taskkill /F /T /PID {s}", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        kill_process(serve_id)
        kill_process(sourcemap_id)
        print("ended processes")
        
        with open(PROCESS_JSON, "w") as file:
            json.dump({}, file)
    else: 
        run_process = lambda cmd: subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        serve_proc = run_process(["rojo", "serve"])
        sourcemap_proc = run_process(["rojo", "sourcemap", "--watch", "sourcemap.json"])
        
        json_obj = {
            serve: serve_proc.pid,
            sourcemap: sourcemap_proc.pid,
        }

        with open(PROCESS_JSON, "w") as file:
            json.dump(json_obj, file)
            
        print("started processes")

if __name__ == "__main__":
    main()
