import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  bool _isLoading = false; // <<< penting

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text(
          "Login Ramadhan Fakhtur Rakhman",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [_header(), const SizedBox(height: 18), _cardLogin()],
            ),
          ),
        ),
      ),
    );
  }

  // ===============================
  // Header
  // ===============================
  Widget _header() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white,
          child: Icon(Icons.storefront, size: 46, color: Colors.blue),
        ),
        SizedBox(height: 10),
        Text(
          "Tokokita",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Silakan login untuk melanjutkan",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  // ===============================
  // Card Form Login
  // ===============================
  Widget _cardLogin() {
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
          const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _emailField(),
          const SizedBox(height: 14),

          const Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _passwordField(),
          const SizedBox(height: 18),

          _buttonLogin(),
          const SizedBox(height: 12),

          _menuRegistrasi(),
        ],
      ),
    );
  }

  // ===============================
  // Email
  // ===============================
  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 15),
      showCursor: true,
      decoration: InputDecoration(
        hintText: "contoh@gmail.com",
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email harus diisi";
        if (!value.contains("@")) return "Format email tidak valid";
        return null;
      },
    );
  }

  // ===============================
  // Password
  // ===============================
  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscure,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: "Masukkan password",
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Password harus diisi";
        if (value.length < 4) return "Password minimal 4 karakter";
        return null;
      },
    );
  }

  // ===============================
  // Tombol Login (LOGIKA SUDAH SAMA)
  // ===============================
  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate && !_isLoading) {
            _submit(); // <<< PENTING
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Login",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  // ===============================
  // LOGIKA LOGIN BLOC (ASLINYA TOKOKITA)
  // ===============================
  void _submit() {
    setState(() => _isLoading = true);

    LoginBloc.login(
      email: _emailController.text,
      password: _passwordController.text,
    ).then(
      (value) async {
        setState(() => _isLoading = false);

        if (value.status == true) {
          await UserInfo().setToken(value.token.toString());
          await UserInfo().setUserID(int.parse(value.userID.toString()));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProdukPage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => const WarningDialog(
              description: "Login gagal, silahkan coba lagi",
            ),
          );
        }
      },
      onError: (error) {
        setState(() => _isLoading = false);
        showDialog(
          context: context,
          builder: (_) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      },
    );
  }

  // ===============================
  // Menu Registrasi
  // ===============================
  Widget _menuRegistrasi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum punya akun? "),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()),
            );
          },
          child: const Text(
            "Registrasi",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
