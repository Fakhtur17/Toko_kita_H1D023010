import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordKonfirmasiController =
      TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordKonfirmasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Registrasi Ramadhan Fakhtur Rakhman",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _header(),
                const SizedBox(height: 18),
                _cardRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===============================
  // Header Atas
  // ===============================
  Widget _header() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white,
          child: Icon(Icons.person_add_alt_1, size: 44, color: Colors.blue),
        ),
        SizedBox(height: 10),
        Text(
          "Buat Akun Tokokita",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Lengkapi data di bawah ya",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  // ===============================
  // Card Form Registrasi
  // ===============================
  Widget _cardRegistrasi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nama", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _namaField(),
          const SizedBox(height: 14),

          const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _emailField(),
          const SizedBox(height: 14),

          const Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _passwordField(),
          const SizedBox(height: 14),

          const Text(
            "Konfirmasi Password",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          _passwordKonfirmasiField(),
          const SizedBox(height: 18),

          _buttonRegistrasi(),

          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Sudah punya akun? Login"),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================
  // Field Nama
  // ===============================
  Widget _namaField() {
    return TextFormField(
      controller: _namaController,
      decoration: _inputDecoration(
        hint: "Nama lengkap",
        icon: Icons.person_outline,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Nama harus diisi";
        if (value.length < 3) return "Nama minimal 3 karakter";
        return null;
      },
    );
  }

  // ===============================
  // Field Email
  // ===============================
  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration(
        hint: "contoh@gmail.com",
        icon: Icons.email_outlined,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email harus diisi";
        if (!value.contains("@")) return "Format email tidak valid";
        return null;
      },
    );
  }

  // ===============================
  // Field Password
  // ===============================
  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePass,
      decoration: _inputDecoration(
        hint: "Minimal 6 karakter",
        icon: Icons.lock_outline,
        suffix: IconButton(
          onPressed: () => setState(() => _obscurePass = !_obscurePass),
          icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Password harus diisi";
        if (value.length < 6) return "Password minimal 6 karakter";
        return null;
      },
    );
  }

  // ===============================
  // Field Konfirmasi Password
  // ===============================
  Widget _passwordKonfirmasiField() {
    return TextFormField(
      controller: _passwordKonfirmasiController,
      obscureText: _obscureConfirm,
      decoration: _inputDecoration(
        hint: "Ulangi password",
        icon: Icons.lock_reset_outlined,
        suffix: IconButton(
          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Konfirmasi password harus diisi";
        }
        if (value != _passwordController.text) {
          return "Konfirmasi password tidak sama";
        }
        return null;
      },
    );
  }

  // ===============================
  // Tombol Registrasi
  // ===============================
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // TODO: simpan registrasi kalau sudah ada servicenya
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registrasi berhasil!")),
            );
            Navigator.pop(context); // balik ke login
          }
        },
        child: const Text(
          "Registrasi",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ===============================
  // Dekorasi Input biar konsisten
  // ===============================
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 1.4),
      ),
    );
  }
}
