# tokokita

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Aplikasi Tokokita adalah sebuah aplikasi mobile berbasis Flutter yang dirancang dengan struktur modular serta alur navigasi yang berurutan mulai dari proses autentikasi hingga pengelolaan data produk. Pengembangan aplikasi ini dimulai dari pendefinisian beberapa model data yang menjadi fondasi utama dalam pengolahan informasi, yaitu model Login, Produk, dan Registrasi. Setiap model disusun menggunakan pendekatan object mapping, di mana data yang berasal dari JSON server dapat dikonversi secara otomatis menjadi objek Dart dengan struktur yang lebih mudah diakses. Model Login, misalnya, menerima data berupa kode status, token autentikasi, ID pengguna, dan email pengguna, yang semuanya dikelola melalui factory Login.fromJson(). Model ini memastikan bahwa proses autentikasi dapat berlangsung dengan standar yang jelas dan memisahkan antara login berhasil dan gagal. Sementara itu, model Produk berfungsi sebagai representasi setiap barang yang ditampilkan dalam aplikasi, mencakup id, kode produk, nama produk, dan harga. Model ini digunakan di seluruh modul aplikasi—baik dalam daftar produk, detail produk, maupun form tambah dan edit produk. Adapun model Registrasi merupakan struktur data untuk menampung hasil pendaftaran pengguna baru.

Alur aplikasi dimulai dari file main.dart, yang berfungsi sebagai pintu masuk utama program. Pada file ini, aplikasi menginisialisasi widget MyApp, kemudian mengatur bahwa halaman pertama yang harus ditampilkan adalah LoginPage. Dengan demikian, setiap kali aplikasi dibuka, pengguna selalu diarahkan menuju halaman login terlebih dahulu. Ini juga menjadi dasar bahwa aplikasi Tokokita menerapkan pola authentication-gated content, yaitu semua konten berada di balik proses login. Meskipun Flutter menyediakan halaman bawaan berupa MyHomePage, halaman tersebut tidak digunakan dalam aplikasi ini, karena seluruh navigasi diarahkan melalui LoginPage.

Pada halaman LoginPage, aplikasi menyajikan antarmuka modern yang dibangun dengan pendekatan visual card, ikon aplikasi, serta tata letak form yang bersih. Pengguna diminta memasukkan email dan password. Sistem validasi diterapkan secara ketat, misalnya email wajib berformat benar dan password minimal empat karakter. Validasi dilakukan melalui mekanisme Form dan GlobalKey<FormState> yang memastikan bahwa seluruh data memenuhi syarat sebelum aplikasi mengizinkan pengguna melanjutkan. Jika input sudah sesuai, aplikasi melakukan navigasi menuju ProdukPage dengan menggunakan Navigator.pushReplacement, yang berarti halaman login dihapus dari navigation stack, sehingga pengguna tidak dapat kembali ke halaman login hanya dengan menekan tombol back. Hal ini menciptakan alur login yang aman dan terstruktur. Tidak hanya itu, LoginPage juga menyediakan tautan menuju halaman RegistrasiPage, sebagai alternatif bagi pengguna baru.

Halaman RegistrasiPage dirancang untuk menangani pembuatan akun baru oleh pengguna. Pada halaman ini terdapat form yang lebih kompleks karena mencakup input nama lengkap, email, password, dan konfirmasi password. Validasi dilakukan secara berlapis: nama minimal tiga karakter, email harus valid, password minimal enam karakter, dan konfirmasi password harus sama dengan password sebelumnya. Ketika seluruh input telah sesuai, aplikasi menampilkan pesan snackbar “Registrasi berhasil!” dan mengarahkan pengguna kembali ke halaman login menggunakan Navigator.pop(context). Dengan pendekatan ini, aplikasi memastikan bahwa proses registrasi berjalan aman, valid, dan sesuai standar pengumpulan data pengguna.

Setelah login berhasil, pengguna diarahkan menuju halaman ProdukPage, yang merupakan pusat aktivitas aplikasi. Pada halaman ini pengguna dapat melihat daftar produk yang ditampilkan dalam bentuk kartu menggunakan widget ItemProduk. Daftar ini ditampilkan menggunakan ListView, sehingga pengguna dapat menggulir produk secara vertikal. Setiap produk memiliki atribut nama dan harga. Ketika pengguna mengetuk salah satu kartu produk, aplikasi akan menavigasikan pengguna menuju halaman ProdukDetail, yang menampilkan informasi lengkap mengenai produk tersebut, mencakup kode produk, nama produk, dan harga produk. Halaman ini juga menyediakan tombol EDIT dan DELETE. Tombol EDIT akan membuka halaman ProdukForm dalam mode edit, di mana data lama produk secara otomatis dimuat ke dalam form. Tombol DELETE saat ini belum memiliki logika penghapusan, namun disediakan sebagai placeholder untuk pengembangan lebih lanjut.

Pada halaman ProdukPage, terdapat pula ikon tambah produk di bagian AppBar. Ketika ikon tambah ditekan, pengguna dibawa menuju halaman ProdukForm, yang berfungsi sebagai halaman tambah produk baru. ProdukForm merupakan form serbaguna karena dapat berfungsi untuk dua mode, yaitu mode tambah dan mode edit. Mode ini ditentukan berdasarkan apakah halaman menerima data produk dari halaman sebelumnya. Jika ProdukForm menerima objek produk, maka ia masuk ke mode edit: judul form berubah menjadi "Ubah Produk", tombol berubah menjadi "Ubah", dan textfield otomatis terisi data lama. Namun jika form tidak menerima produk, maka form berada pada mode tambah dengan judul “Tambah Produk”, tombol “Simpan”, dan seluruh input tetap kosong. Validasi form tetap diterapkan untuk memastikan kode produk, nama produk, dan harga tidak kosong.

Selain fungsi tambah, edit, dan melihat produk, ProdukPage juga menyediakan menu Logout pada drawer. Ketika menu ini ditekan, drawer ditutup lebih dahulu, lalu aplikasi mengembalikan pengguna ke LoginPage menggunakan Navigator.pushAndRemoveUntil, yang artinya seluruh halaman sebelumnya benar-benar dihapus dari history. Dengan demikian, pengguna tidak bisa kembali ke ProdukPage dengan menekan tombol back setelah logout. Ini merupakan salah satu praktik standar keamanan dalam aplikasi autentikasi.

Secara keseluruhan, hubungan antarhalaman aplikasi Tokokita mengikuti alur yang logis dan terstruktur. Aplikasi dimulai dari LoginPage, kemudian mengalir ke ProdukPage setelah autentikasi berhasil. Dari ProdukPage, pengguna dapat mengakses ProdukForm untuk menambah produk baru atau melalui ProdukDetail untuk mengedit produk yang sudah ada. Pengguna juga dapat kembali ke halaman login melalui fitur logout. Melalui struktur tersebut, aplikasi berhasil membangun alur CRUD produk lengkap yang elegan dan mudah dipahami. Model data digunakan secara konsisten untuk mengelola informasi produk, login, dan registrasi. Navigasi antarhalaman menggunakan berbagai jenis Navigator (push, pushReplacement, pushAndRemoveUntil) untuk memastikan kontrol penuh terhadap perpindahan halaman dan keamanan alur aplikasi. Semua ini menjadikan aplikasi Tokokita sebagai contoh implementasi Flutter multihalaman yang baik, terstruktur, aman, dan mudah dikembangkan menjadi aplikasi toko online yang sesungguhnya.

<img width="678" height="892" alt="image" src="https://github.com/user-attachments/assets/67f1c712-f2aa-45fc-8033-d5f73f33ab64" />

<img width="679" height="895" alt="image" src="https://github.com/user-attachments/assets/82a6155b-6afe-4fc5-986f-3171ba50102b" />

<img width="677" height="889" alt="image" src="https://github.com/user-attachments/assets/2004610b-d30c-4def-a099-bc4fab27e31a" />

<img width="677" height="886" alt="image" src="https://github.com/user-attachments/assets/63aedb7d-e058-4ee5-9c01-20fa421d87d1" />

<img width="676" height="883" alt="image" src="https://github.com/user-attachments/assets/781d8396-bdf5-4e40-99e5-c68790251f2a" />

<img width="665" height="889" alt="image" src="https://github.com/user-attachments/assets/acf856df-2041-43f7-8117-4145dba6a179" />



