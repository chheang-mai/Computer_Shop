import 'package:flutter/material.dart';

class NotifiScreen extends StatelessWidget {
  const NotifiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_NotiItem> notifications = [
      _NotiItem(
        title: "Order Confirmed ✅",
        message: "Your order #1023 has been confirmed successfully.",
        time: "2 min ago",
        icon: Icons.check_circle,
        isUnread: true,
      ),
      _NotiItem(
        title: "Delivery Update 🚚",
        message: "Your package is on the way. Estimated delivery tomorrow.",
        time: "1 hour ago",
        icon: Icons.local_shipping,
        isUnread: true,
      ),
      _NotiItem(
        title: "New Product 🔥",
        message: "ASUS RTX 4060 laptops are now available in stock.",
        time: "Yesterday",
        icon: Icons.new_releases,
        isUnread: false,
      ),
      _NotiItem(
        title: "Discount Offer 🎁",
        message: "Get 10% off on gaming accessories this week.",
        time: "2 days ago",
        icon: Icons.discount,
        isUnread: false,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Marked all as read ✅")),
              );
            },
            child: const Text(
              "Read",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cleared ✅ (static UI)")),
              );
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const _EmptyNoti()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return _NotiCard(item: n);
              },
            ),
    );
  }
}

class _NotiCard extends StatelessWidget {
  const _NotiCard({required this.item});

  final _NotiItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.message,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (item.isUnread)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyNoti extends StatelessWidget {
  const _EmptyNoti();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            "No notifications",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          Text(
            "You're all caught up 🎉",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _NotiItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool isUnread;

  _NotiItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.isUnread,
  });
}
