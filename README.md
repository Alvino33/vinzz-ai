# VinAI

CLI AI pribadi berbasis model open-weight, dengan GitHub Actions sebagai worker CPU sementara.

## Status

Prototipe awal. Setiap pesan memicu satu workflow baru. Runner tidak persisten, tidak punya GPU, dan respons dapat memerlukan beberapa menit karena model diunduh saat job berjalan.

## Model

Qwen2.5-Coder-3B-Instruct, GGUF Q4_K_M. Dipilih sebagai titik awal yang lebih realistis untuk runner CPU dengan RAM terbatas dibanding model 7B/8B.

## Menjalankan CLI

1. Install Python 3.10+.
2. Install dependency: `pip install -r requirements.txt`.
3. Buat GitHub Personal Access Token dengan izin Actions untuk repository ini. Simpan token secara privat sebagai environment variable `GITHUB_TOKEN`; jangan masukkan token ke kode atau commit.
4. Jalankan:
   ```bash
   python vinai.py
   ```

Token harus punya izin untuk memicu workflow dan membaca artifact. Repository ini publik, jadi jangan kirim rahasia, data pribadi, atau kode sensitif ke prompt.

## Batasan penting

- Ini eksperimen pribadi, bukan hosting produksi atau layanan 24/7.
- GitHub Actions memiliki kuota menit dan batas durasi job; penggunaan gratis bergantung pada jenis repository dan kuota akun.
- Tidak ada GPU. Inferensi CPU bisa lambat.
- Prototipe ini belum menyimpan riwayat percakapan atau konteks antarpesan.
- Runner mengunduh model setiap job, sehingga waktu tunggu dan penggunaan bandwidth cukup besar.
- Periksa lisensi model dan ketentuan GitHub sebelum penggunaan lebih lanjut.

## Perintah CLI

- `/help` — bantuan singkat
- `/exit` — keluar

## Struktur

- `vinai.py` — terminal client
- `.github/workflows/ai.yml` — worker inferensi
- `requirements.txt` — dependency Python
