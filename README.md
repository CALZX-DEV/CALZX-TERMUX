# CALZX TERMUX — Neon Hacker Edition

Terminal theme untuk Termux Android: banner ASCII art rainbow, panel status bergaya cyber, informasi perangkat, nama banner yang bisa dikustomisasi, dan startup otomatis.

Channel YouTube: https://youtube.com/@calzxchannel?si=fOW0uEhe90ZQoNAi

## Upload ke GitHub
1. Buka https://github.com/new lalu login.
2. Buat repository bernama `CALZX-TERMUX` dan pilih **Public**.
3. Ekstrak ZIP ini.
4. Di repository, pilih **Add file → Upload files**.
5. Unggah isi folder proyek ini (jangan unggah folder pembungkus luarnya): `README.md`, `install.sh`, `uninstall.sh`, dan folder `bin`.
6. Tekan **Commit changes**.

## Instal di Termux
Ganti `USERNAME_GITHUB` dengan username GitHub kamu:

```bash
pkg update
pkg install git bash figlet
git clone https://github.com/USERNAME_GITHUB/CALZX-TERMUX.git
cd CALZX-TERMUX
bash install.sh
```

Installer menampilkan ajakan untuk mengunjungi channel YouTube. Ketik `S` untuk mencoba membukanya, atau tekan Enter untuk lanjut. Ajakan tidak mengunci instalasi.

Setelah installer selesai, jalankan `calzx` untuk tes. Tutup dan buka kembali Termux untuk mencoba startup otomatis.

## Ubah nama dan tampilan
```bash
calzx-config
```

Edit pengaturan seperti berikut:

```bash
CALZX_TITLE="CALZX"
CALZX_SUBTITLE="NEON HACKER TERMINAL"
CALZX_GREETING="Welcome back, CALZX!"
CALZX_SHOW_INFO="true"
CALZX_RAINBOW="true"
CALZX_SHOW_TIPS="true"
```

Nama bisa diganti bebas, misalnya `NYOKZZZ` atau `MY TERMINAL`. Simpan di nano dengan `Ctrl+O`, Enter, lalu `Ctrl+X`. Lihat hasilnya dengan `calzx`.

## Perintah
- `calzx` — tampilkan dashboard terminal.
- `calzx-config` — buka konfigurasi.
- `calzx-uninstall` — hapus hook startup dan skrip tema.

## Keamanan
- Tidak membutuhkan root, API key, atau token GitHub.
- Installer membuat cadangan file startup sebelum mengubahnya.
- Hanya menambahkan blok CALZX bertanda pada `.bashrc` atau `.zshrc`.
- Informasi perangkat hanya membaca data lokal dasar; tidak mengirim data ke internet.
