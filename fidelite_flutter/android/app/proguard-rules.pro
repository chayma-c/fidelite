# Intentionally empty to start. Every plugin this app depends on (Firebase,
# mobile_scanner/ML Kit, flutter_secure_storage, ...) ships its own
# consumer-rules.pro inside its AAR, which R8 picks up automatically -- so
# no explicit -keep rules should be needed. Only add one here if real-device
# testing after enabling minification (see build.gradle.kts) turns up an
# actual runtime break, and note *why* next to the rule that fixes it.
