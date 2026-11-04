#!/usr/bin/env python3
"""VinAI CLI: send one prompt to the private GitHub Actions compute worker."""
import io
import os
import sys
import time
import zipfile
import requests

OWNER = "Alvino33"
REPO = "vinzz-ai"
WORKFLOW = "ai.yml"
API = "https://api.github.com"
TOKEN = os.getenv("GITHUB_TOKEN")

def api(method, path, **kwargs):
    if not TOKEN:
        raise SystemExit("GITHUB_TOKEN belum diset. Buat token GitHub dengan akses Actions, lalu set sebagai environment variable.")
    headers = {
        "Authorization": f"Bearer {TOKEN}",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    response = requests.request(method, API + path, headers=headers, timeout=60, **kwargs)
    response.raise_for_status()
    return response

def ask(prompt):
    workflow_path = f"/repos/{OWNER}/{REPO}/actions/workflows/{WORKFLOW}"
    before = api("GET", workflow_path + "/runs", params={"branch": "main", "event": "workflow_dispatch", "per_page": 1}).json()
    previous_id = before["workflow_runs"][0]["id"] if before["workflow_runs"] else 0

    api("POST", workflow_path + "/dispatches", json={"ref": "main", "inputs": {"prompt": prompt}})
    print("VinAI sedang menyiapkan model dan memproses pesan...")

    run = None
    deadline = time.time() + 900
    while time.time() < deadline:
        data = api("GET", workflow_path + "/runs", params={"branch": "main", "event": "workflow_dispatch", "per_page": 5}).json()
        candidates = [item for item in data["workflow_runs"] if item["id"] != previous_id]
        if candidates:
            run = candidates[0]
            if run["status"] == "completed":
                break
        time.sleep(8)

    if not run or run["status"] != "completed":
        raise SystemExit("Waktu tunggu habis. Cek tab Actions di repository untuk detail.")
    if run["conclusion"] != "success":
        raise SystemExit(f"Workflow gagal ({run['conclusion']}). Cek log di: {run['html_url']}")

    artifacts = api("GET", f"/repos/{OWNER}/{REPO}/actions/runs/{run['id']}/artifacts").json()["artifacts"]
    artifact = next((item for item in artifacts if item["name"] == "vinai-response"), None)
    if not artifact:
        raise SystemExit("Workflow selesai, tetapi file jawaban tidak ditemukan.")
    archive = api("GET", f"/repos/{OWNER}/{REPO}/actions/artifacts/{artifact['id']}/zip")
    with zipfile.ZipFile(io.BytesIO(archive.content)) as bundle:
        print("\nVinAI:")
        print(bundle.read("response.txt").decode("utf-8", errors="replace").strip())

def main():
    print("VinAI CLI — ketik /exit untuk keluar")
    print("Catatan: satu pesan = satu GitHub Actions run; balasan bisa perlu beberapa menit.\n")
    while True:
        try:
            prompt = input("you > ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nSampai jumpa.")
            return
        if not prompt:
            continue
        if prompt == "/exit":
            return
        if prompt == "/help":
            print("Perintah: /help, /exit")
            continue
        try:
            ask(prompt)
        except requests.RequestException as exc:
            print(f"\nKesalahan koneksi GitHub: {exc}")
        except (KeyError, ValueError, zipfile.BadZipFile) as exc:
            print(f"\nRespons GitHub tidak sesuai: {exc}")

if __name__ == "__main__":
    main()
