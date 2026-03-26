import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade700,
                  ],
                ),
              ),
              child: Column(
                children: [
                  if (user?.photoUrl != null)
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user!.photoUrl!),
                    )
                  else
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    user?.fullName ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? 'No email',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildInfoTile(
                      'Authentication Method',
                      user?.authType == 'google' ? 'Google Sign-In' : 'API Login',
                      user?.authType == 'google'
                          ? Icons.g_mobiledata
                          : Icons.api,
                    ),
                    const Divider(),
                    _buildInfoTile(
                      'Username',
                      user?.username ?? 'N/A',
                      Icons.person,
                    ),
                    const Divider(),
                    _buildInfoTile(
                      'Email',
                      user?.email ?? 'N/A',
                      Icons.email,
                    ),
                    if (user?.authType != 'google') ...[
                      const Divider(),
                      _buildInfoTile(
                        'First Name',
                        user?.firstName ?? 'N/A',
                        Icons.person_outline,
                      ),
                      const Divider(),
                      _buildInfoTile(
                        'Last Name',
                        user?.lastName ?? 'N/A',
                        Icons.person_outline,
                      ),
                    ],
                    const Divider(),
                    _buildInfoTile(
                      'Token',
                      user?.token?.substring(0, 20) ?? 'N/A',
                      Icons.vpn_key,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}