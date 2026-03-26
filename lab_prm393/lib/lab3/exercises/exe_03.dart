import 'dart:async';

/// Exercise 3 – Async + Microtask Debugging
/// Goal: Differentiate microtask and event queues
void exercise3_AsyncMicrotaskDebugging() {
  print('\n' + '=' * 80);
  print('EXERCISE 3 – Async + Microtask Debugging');
  print('=' * 80);

  print('\n🎯 Demonstrating event loop priorities:');
  print('   (Microtasks run before event queue tasks)\n');

  print('Starting execution...');

  // 1. Synchronous code - executes immediately
  print('1️⃣ [SYNC] This runs first (synchronous)');

  // 2. Microtask - will run after all sync code but before event queue
  scheduleMicrotask(() {
    print('2️⃣ [MICROTASK] This runs in microtask queue (high priority)');
  });

  // 3. Future (event queue) - will run after microtasks
  Future(() {
    print('3️⃣ [EVENT QUEUE] This runs in event queue (lower priority)');
  });

  // 4. Another microtask
  scheduleMicrotask(() {
    print('4️⃣ [MICROTASK] Another microtask runs after first microtask');
  });

  // 5. Future with delay
  Future.delayed(const Duration(milliseconds: 10), () {
    print('5️⃣ [EVENT QUEUE] Delayed future runs after other event queue tasks');
  });

  // 6. Synchronous code at the end
  print('6️⃣ [SYNC] This runs after all sync code');

  // 7. Explain the execution order
  Future.delayed(const Duration(milliseconds: 50), () {
    print('\n📚 EXPLANATION:');
    print('   • Microtasks (scheduleMicrotask) run immediately after sync code');
    print('   • Event queue tasks (Future) run after all microtasks are complete');
    print('   • This demonstrates Dart\'s event loop priority system');
    print('   • Order: Sync → Microtasks → Event Queue');
  });

  print('\n✅ Exercise 3 completed (check execution order above)!\n');
}