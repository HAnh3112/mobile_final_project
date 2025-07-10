import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Sign in to your account",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: "Login"),
                          Tab(text: "Sign Up"),
                        ],
                        labelColor: Colors.indigo,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.indigo,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 350,
                        child: TabBarView(
                          controller: _tabController,
                          children: [buildLoginTab(), buildSignUpTab()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginTab() {
    return Column(
      children: [
        buildEmailInput(),
        const SizedBox(height: 16),
        buildPasswordInput(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot password?",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget buildSignUpTab() {
    return Column(
      children: [
        buildEmailInput(),
        const SizedBox(height: 16),
        buildPasswordInput(label: "Password"),
        const SizedBox(height: 16),
        buildPasswordInput(label: "Confirm Password"),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text(
            "Create Account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.mail),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget buildPasswordInput({String label = "Password"}) {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() => _showPassword = !_showPassword);
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
